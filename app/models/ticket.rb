class Ticket < ApplicationRecord
  belongs_to :person
  has_many :mailers
  has_many :response_ivrs, dependent: :destroy
  has_many :response_surveys, dependent: :destroy
  
  def self.get_tickets_from_crm(from_date, to_date)
    unab_api = UnabApi.new
    check = StringUtils.new
    ticket_hash = {}
    from_date = from_date.to_datetime
    to_date = to_date.to_datetime

    total_tickets, total_valid_tickets = 0, 0
    from_date.upto(to_date) do |date|
      date = date.strftime("%Y-%m-%d")
      tickets = unab_api.get_ticket_created(date)[:casos_creados]
      #puts " - Tickets del dia #{date}: #{tickets.count}"

      Person.transaction do
        tickets.each do |ticket_created|
          if ticket_created.kind_of?(Hash) && ticket_created.key?(:ctc_wa_rut) && ticket_created.key?(:subjectid)
            rut = check.normalize_rut(ticket_created[:ctc_wa_rut])
            category = find_category_id(ticket_created[:subjectid])

            if rut.present? && category.present?
              #puts "     Ticket | ticketnumber: #{ticket_created[:ticketnumber]}, ctc_wa_rut: #{ticket_created[:ctc_wa_rut]} (rut: #{rut}), subjectid: #{ticket_created[:subjectid]} (category: #{category})"
              person = Person.find_or_initialize_by(rut: check.normalize_rut(ticket_created[:ctc_wa_rut]))
              person.full_name = ticket_created[:customerid]
              person.cellphone = check.normalize_phone(ticket_created[:ctc_mobilephone])
              person.phone     = check.normalize_phone(ticket_created[:ctc_telephone2])
              person.email     = check.normalize_mail(ticket_created[:ctc_emailaddress1])
              person.career    = ticket_created[:mksv_carreraid]
              #homologate_careers
              if ticket_created[:mksv_carreraid].present? && ticket_created[:mksv_carreraid].split(' ').last.include?('E') && ticket_created[:mksv_carreraid].split(' ').last =~ /\d/ 
                career = ticket_created[:mksv_carreraid].split(' ')
                career.pop
                person.career = career.join(" ")
              end

              person.campus   = ticket_created[:mksv_campusid]
              person.faculty  = ticket_created[:carr_mksv_facultadid]
              #person.regimen  = ticket_created[:da_mksv_regimen]
              person.level = ticket_created[:carr_mksv_unidaddenegocioid]
              person.career_code = ticket_created[:carr_mksv_codigocarrera]
              if ticket_created[:carr_mksv_codigocarrera].present?
                if ticket_created[:carr_mksv_codigocarrera].gsub('UNAB', '').first.include?('1')
                  person.regimen = 'Diurno'
                elsif ticket_created[:carr_mksv_codigocarrera].gsub('UNAB', '').first.include?('2')
                  person.regimen = 'Vespertino'
                elsif ticket_created[:carr_mksv_codigocarrera].gsub('UNAB', '').first.include?('3')
                  person.regimen = 'Online'
                end
              end

              #check if there are fields 
              if unab_api.get_client_by_rut(ticket_created[:ctc_wa_rut])[:salida][:estado] == '1'
                if unab_api.get_client_by_rut(ticket_created[:ctc_wa_rut])[:contacto].kind_of?(Array)
                  unab_api.get_client_by_rut(ticket_created[:ctc_wa_rut])[:contacto].each do |element|
                    person.contact_id = element[:contactid]
                  end 
                else
                  contact_id = unab_api.get_client_by_rut(ticket_created[:ctc_wa_rut])[:contacto][:contactid]
                  person.contact_id = contact_id
                end
              else
                person.contact_id = nil
              end
              person.save

              # Initialize person's ticket
              ticket                      = person.tickets.find_or_initialize_by(crm_ticket_id: ticket_created[:ticketnumber])
              ticket.business_owner_unit  = ticket_created[:mksv_unidaddenegociodelpropietarioid]
              ticket.business_author_unit = ticket_created[:mksv_unidaddenegociodelautorid]
              ticket.created_by           = ticket_created[:createdby]
              ticket.owner_by             = ticket_created[:ownerid]
              ticket.incident_id          = ticket_created[:incidentid]
              ticket.income_channel       = ticket_created[:mksv_canaldeingresoid]

              if ticket.income_channel.present?
                if ticket.income_channel.downcase.include?('facebook') || ticket.income_channel.downcase.include?('instagram') || ticket.income_channel.downcase.include?('twitter')  
                  ticket.income_channel_rec = 'Call Center RRSS'
                  
                elsif ticket.income_channel.downcase.include?('web') || ticket.income_channel.downcase.include?('correo electrónico')
                  ticket.income_channel_rec = 'Call Center Web'
        
                elsif ticket.income_channel.downcase.include?('call center') || ticket.income_channel.strip.parameterize.include?('telefono') || ticket.income_channel.downcase.include?('contact center')
                  ticket.income_channel_rec = 'Call Center Telefonico'
        
                elsif ticket.income_channel.downcase.include?('mas') || ticket.income_channel.downcase.include?('presencial')
                  ticket.income_channel_rec = ticket.income_channel
                end
              end

              ticket.modify_by    = ticket_created[:modifiedby]
              ticket.case_phase   = ticket_created[:mksv_fasedelcasoname]
              ticket.crm_classification = ticket_created[:subjectid]
              ticket.category_id  = category
              Category.set_categories_to_ticket(ticket)
              ticket.state        = ticket_created[:statecodename]
              ticket.status       = ticket_created[:statuscodename]
              ticket.priority     = ticket_created[:prioritycodename]
              ticket.case_type    = ticket_created[:casetypecodename]
              ticket.created_time = DateTime.strptime(ticket_created[:createdon],"%m/%d/%Y %l:%M:%S %p")
              ticket.elapsed_time = (DateTime.current.to_i - ticket.created_time.to_f)/(3600*24)
              ticket.updated_time = DateTime.strptime(ticket_created[:modifiedon],"%m/%d/%Y %l:%M:%S %p")
              ticket.impact_name  = ticket_created[:mksv_impactoname]
              ticket.close_first_line = ticket_created[:mksv_cierreenprimeralineaname]
              ticket.save
              
              #if ticket.persisted?
                #puts "   Ticket: #{ticket.crm_ticket_id} | Fecha: #{ticket.created_time} (#{ticket_created[:createdon]}) "
                total_valid_tickets += 1
              #end
            else
              if ticket_created[:ctc_wa_rut].blank?
                LostReasonTicket.transaction do
                  lost_ticket              = LostReasonTicket.find_or_initialize_by(crm_ticket_id: ticket_created[:ticketnumber])
                  lost_ticket.lost_reason  = "Rut individuo no presente"
                  lost_ticket.created_time = DateTime.strptime(ticket_created[:createdon],"%m/%d/%Y %l:%M:%S %p")
                  lost_ticket.updated_time = DateTime.strptime(ticket_created[:modifiedon],"%m/%d/%Y %l:%M:%S %p")
                  lost_ticket.save
                  #byebug if !lost_ticket.persisted?
                end
              elsif rut.blank?
                LostReasonTicket.transaction do
                  lost_ticket              = LostReasonTicket.find_or_initialize_by(crm_ticket_id: ticket_created[:ticketnumber])
                  lost_ticket.lost_reason  = "Rut individuo no válido"
                  lost_ticket.created_time = DateTime.strptime(ticket_created[:createdon],"%m/%d/%Y %l:%M:%S %p")
                  lost_ticket.updated_time = DateTime.strptime(ticket_created[:modifiedon],"%m/%d/%Y %l:%M:%S %p")
                  lost_ticket.save
                  #byebug if !lost_ticket.persisted?
                end
              elsif category.blank?
                #puts "Ticket: #{ticket_created[:ticketnumber]} subject_id: #{ticket_created[:subjectid]} created_time: #{DateTime.strptime(ticket_created[:createdon],"%m/%d/%Y %l:%M:%S %p")}"
                #puts "------------------------------"
                LostReasonTicket.transaction do
                  lost_ticket              = LostReasonTicket.find_or_initialize_by(crm_ticket_id: ticket_created[:ticketnumber])
                  lost_ticket.lost_reason  = "Categoria no registrada"
                  lost_ticket.created_time = DateTime.strptime(ticket_created[:createdon],"%m/%d/%Y %l:%M:%S %p")
                  lost_ticket.updated_time = DateTime.strptime(ticket_created[:modifiedon],"%m/%d/%Y %l:%M:%S %p")
                  lost_ticket.save
                  #byebug if !lost_ticket.persisted?
                end
              end
            end
          end

          total_tickets += 1
        end
      end if tickets.present? 
    end

    puts "   Tickets totales validos del periodo #{from_date.strftime("%F")} a #{to_date.strftime("%F")}: #{total_valid_tickets} de #{total_tickets}"
    AlertMailer.send_mail_err("Tickets totales validos: #{total_valid_tickets} de #{total_tickets}, en el periodo #{from_date} a #{to_date}").deliver_now if total_valid_tickets == 0
  end

  def self.get_tickets_close_from_crm(from_date, to_date)
    unab_api = UnabApi.new
    from_date = from_date.to_datetime
    to_date = to_date.to_datetime
    from_date.upto(to_date) do |date|
      date = date.strftime("%Y-%m-%d")
      
      if !unab_api.get_ticket_closed(date)[:salida][:estado] == '3'
        unab_api.get_ticket_closed(date)[:casos_cerrados].each do |ticket_closed|
          Ticket.transaction do        
            ticket = Ticket.find_by(crm_ticket_id: ticket_closed[:ticketnumber])
            
            if ticket.present?
              ticket.closed_time = ticket_closed.key?(:modifiedon) && ticket_closed[:modifiedon].present? ? DateTime.strptime(ticket_created[:modifiedon],"%m/%d/%Y %l:%M:%S %p") : nil
              ticket.save

              puts "   Ticket close: #{ticket.crm_ticket_id} | Fecha: #{date}".colorize(:light_red)
            end

          end
        end

      end
    end
  end

  def self.find_category_id(category)
    if category.present?
      cat = category.split(' ')
      cat_obj = Category.find_by(internal_id: cat[0])

      if cat_obj.present?
        cat_obj.id
      else
        nil
      end
    else 
      nil
    end
  end

  def self.add_income_channel_rec
    Ticket.all.each do |ticket|
      if ticket.income_channel.present?
        if ticket.income_channel.downcase.include?('facebook') || ticket.income_channel.downcase.include?('instagram') || ticket.income_channel.downcase.include?('twitter') 
          ticket.income_channel_rec = 'Call Center RRSS'

        elsif ticket.income_channel.downcase.include?('web') || ticket.income_channel.downcase.include?('correo electrónico') 
          ticket.income_channel_rec = 'Call Center Web'

        elsif ticket.income_channel.downcase.include?('call center') || ticket.income_channel.downcase.include?('contact center')
          ticket.income_channel_rec = 'Call Center Telefonico'

        elsif ticket.income_channel.downcase.include?('mas') || ticket.income_channel.downcase.include?('presencial')
          ticket.income_channel_rec = ticket.income_channel
        end
        
        ticket.save
      end
    end
  end
end
