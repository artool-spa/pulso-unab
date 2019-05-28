class Ticket < ApplicationRecord
  belongs_to :person
  has_many :mailers
  has_many :response_ivrs
  has_many :response_surveys
  
  #@test_subject = Person.where(full_name: 'CRISTIAN MANUEL FERNANDEZ VASQUEZ').first
  #if @test_subject.full_name == 'CRISTIAN MANUEL FERNANDEZ VASQUEZ' && @test_subject.send_email == false
  #  AlertMailer.send_mail(@test_subject, "testing_unab").deliver_now
  #end
  @ticket_hash = {}

  def self.get_tickets_from_crm(from_date, to_date)
    unab_api = UnabApi.new
    check = StringUtils.new
    ticket_hash = {}
    from_date = from_date.to_datetime
    to_date = to_date.to_datetime
    from_date.upto(to_date) do |date|
      date = date.strftime("%Y-%m-%d")
      unab_api.get_ticket_created(date)[:casos_creados].each do |ticket_created|
        Person.transaction do
          if (ticket_created[:ctc_wa_rut].present? && !check.normalize_rut(ticket_created[:ctc_wa_rut]).nil? && find_category_id(ticket_created[:subjectid]).present?)
            person = Person.find_or_initialize_by(rut: check.normalize_rut(ticket_created[:ctc_wa_rut]))
            person.full_name = ticket_created[:customerid]
            person.cellphone =  check.normalize_phone(ticket_created[:ctc_mobilephone])
            person.phone = check.normalize_phone(ticket_created[:ctc_telephone2])
            person.email = check.normalize_mail(ticket_created[:ctc_emailaddress1])
            person.career = ticket_created[:mksv_carreraid]
            #homologate_careers
            if ticket_created[:mksv_carreraid].present? && ticket_created[:mksv_carreraid].split(' ').last.include?('E') && ticket_created[:mksv_carreraid].split(' ').last =~ /\d/ 
              career = ticket_created[:mksv_carreraid].split(' ')
              career.pop
              person.career = career.join(" ")
            end
            person.campus = ticket_created[:mksv_campusid]
            person.faculty = ticket_created[:prog_mksv_facultadid]
            person.regimen = ticket_created[:da_mksv_regimen]
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
            if person.persisted?
              puts "Person: #{person.full_name} | Fecha: #{date}"
            end
    
            ticket = person.tickets.find_or_initialize_by(crm_ticket_id: ticket_created[:ticketnumber])
            ticket.business_owner_unit = ticket_created[:mksv_unidaddenegociodelpropietarioid]
            ticket.business_author_unit = ticket_created[:mksv_unidaddenegociodelautorid]
                    
            ticket.created_by = ticket_created[:createdby]
            ticket.owner_by = ticket_created[:ownerid]
            ticket.incident_id = ticket_created[:incidentid]
    
            ticket.income_channel = ticket_created[:mksv_canaldeingresoid]
            ticket.modify_by = ticket_created[:modifiedby]
            ticket.case_phase = ticket_created[:mksv_fasedelcasoname]
            ticket.category_id = find_category_id(ticket_created[:subjectid])
            Category.set_categories_to_ticket(ticket)
            ticket.state = ticket_created[:statecodename]
            ticket.status = ticket_created[:statuscodename]
            ticket.priority = ticket_created[:prioritycodename]
            ticket.case_type = ticket_created[ :casetypecodename]
            ticket.created_time = DateTime.strptime(ticket_created[:createdon],"%m/%d/%Y %l:%M:%S %p")
            ticket.elapsed_time = (DateTime.current.to_i - ticket.created_time.to_f)/(3600*24)
            ticket.updated_time = DateTime.strptime(ticket_created[:modifiedon],"%m/%d/%Y %l:%M:%S %p")
            ticket.save
            
            if ticket.persisted?
              puts "Ticket: #{ticket.crm_ticket_id} | Fecha: #{ticket.created_time} (#{ticket_created[:createdon]}) ".colorize(:light_blue)
              puts "------------------------------"
            end

          else
            if !ticket_created[:ctc_wa_rut].present?
              LostReasonTicket.transaction do
                lost_ticket = LostReasonTicket.find_or_initialize_by(crm_ticket_id: ticket_created[:ticketnumber])
                lost_ticket.lost_reason = "Rut individuo no presente"
                lost_ticket.created_time = DateTime.strptime(ticket_created[:createdon],"%m/%d/%Y %l:%M:%S %p")
                lost_ticket.updated_time = DateTime.strptime(ticket_created[:modifiedon],"%m/%d/%Y %l:%M:%S %p")
                lost_ticket.save
                #byebug if !lost_ticket.persisted?
              end
              
            elsif !check.normalize_rut(ticket_created[:ctc_wa_rut]).nil?
              LostReasonTicket.transaction do
                lost_ticket = LostReasonTicket.find_or_initialize_by(crm_ticket_id: ticket_created[:ticketnumber])
                lost_ticket.lost_reason = "Rut individuo no válido"
                lost_ticket.created_time = DateTime.strptime(ticket_created[:createdon],"%m/%d/%Y %l:%M:%S %p")
                lost_ticket.updated_time = DateTime.strptime(ticket_created[:modifiedon],"%m/%d/%Y %l:%M:%S %p")
                lost_ticket.save
                #byebug if !lost_ticket.persisted?
              end

            elsif !find_category_id(ticket_created[:subjectid]).present?
              LostReasonTicket.transaction do
                lost_ticket = LostReasonTicket.find_or_initialize_by(crm_ticket_id: ticket_created[:ticketnumber])
                lost_ticket.lost_reason = "Categoria no registrada"
                lost_ticket.created_time = DateTime.strptime(ticket_created[:createdon],"%m/%d/%Y %l:%M:%S %p")
                lost_ticket.updated_time = DateTime.strptime(ticket_created[:modifiedon],"%m/%d/%Y %l:%M:%S %p")
                lost_ticket.save
                #byebug if !lost_ticket.persisted?
              end

            end
          end
        end
      end
    end
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
              puts "Ticket close: #{ticket.crm_ticket_id} | Fecha: #{date}".colorize(:light_red)
              puts "------------------------------"
            end

          end
        end

      end
    end
  end

  def self.find_category_id(category)
    cat = category.split(' ')
    cat_obj = Category.find_by(internal_id: cat[0])
    if !cat_obj.nil?
      cat_obj.id
    else
      nil
    end
  end

end

