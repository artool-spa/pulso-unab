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
    from_date.upto(to_date) do |date|
      date = date.strftime("%Y-%m-%d")
      unab_api.get_ticket_created(date)[:casos_creados].each do |ticket_created|
        Person.transaction do
          if ticket_created[:ctc_wa_rut].present?
            person = Person.find_or_initialize_by(rut: ticket_created[:ctc_wa_rut])
            person.full_name = ticket_created[:customerid]
            person.cellphone =  check.normalize_phone(ticket_created[:ctc_mobilephone])
            person.phone = check.normalize_phone(ticket_created[:ctc_telephone2])
            person.email = check.normalize_mail(ticket_created[:ctc_emailaddress1])
            person.career = ticket_created[:mksv_carreraid]
            person.campus = ticket_created[:mksv_campusid]
            person.faculty = ticket_created[:prog_mksv_facultadid]
            
            #check if there are fields 
            if unab_api.get_client_by_rut(person.rut)[:salida][:estado] == '1'
              if unab_api.get_client_by_rut(person.rut)[:contacto].kind_of?(Array)
                unab_api.get_client_by_rut(person.rut)[:contacto].each do |element|
                  person.contact_id = element[:contactid]
                end 
              else
                contact_id = unab_api.get_client_by_rut(person.rut)[:contacto][:contactid]
                person.contact_id = contact_id
              end
            else
              person.contact_id = nil
            end
    
            person.save
            puts "persona guardada fecha:#{date}"
            ticket = person.tickets.find_or_initialize_by(crm_ticket_id: ticket_created[:ticketnumber])
            ticket.business_owner_unit = ticket_created[:mksv_unidaddenegociodelpropietarioid]
            ticket.business_author_unit = ticket_created[:mksv_unidaddenegociodelautorid]
                    
            ticket.created_by = ticket_created[:createdby]
            ticket.owner_by = ticket_created[:ownerid]
            ticket.incident_id = ticket_created[:incidentid]
    
            ticket.income_channel = ticket_created[:mksv_canaldeingresoid]
            ticket.modify_by = ticket_created[:modifiedby]
            ticket.case_phase = ticket_created[:mksv_fasedelcasoname]
            ticket.category = ticket_created[:subjectid]
            ticket.state = ticket_created[:statecodename]
            ticket.status = ticket_created[:statuscodename]
            ticket.priority = ticket_created[:prioritycodename]
            ticket.case_type = ticket_created[ :casetypecodename]
    
            ticket.created_time = ticket_created[:createdonname].to_datetime
            ticket.updated_time = ticket_created[:modifiedonname].to_datetime
            
            ticket.save
            puts "ticket guardado fecha: #{date}"
            #ticket_hash[ticket.crm_ticket_id] = ticket.id
            
            #mailer_send = person.log_mailer_sends.find_or_initialize_by(person_id: person.id)
            #mailer_send.had_answer = false
            #mailer_send.save
    
            #if person.id == 2
            #  @person = person
            #  AlertMailer.send_mail(@person, "testing_unab").deliver_now
            #  person.send_email = true
            #  person.save
            #end
          end
        end
      end
    end
    #ticket_hash
  end

  def self.get_tickets_close_from_crm(from_date, to_date)
    unab_api = UnabApi.new
    from_date.upto(to_date) do |date|
      date = date.strftime("%Y-%m-%d")
      if !unab_api.get_ticket_closed(date)[:salida][:estado] == '3'
        unab_api.get_ticket_closed(date)[:casos_cerrados].each do |ticket_closed|
          Ticket.transaction do        
            ticket = Ticket.find_by(crm_ticket_id: ticket_closed[:ticketnumber])
            if ticket.present?
              ticket.closed_time = ticket_closed.key?(:modifiedonname) && ticket_closed[:modifiedonname].present? ? ticket_closed[:modifiedonname].to_datetime : nil
              ticket.save
            end

          end
        end

      end
    end
  end

  def self.check_send_mail(date_from, date_to)
    temp_alta = true
    temp_baja = false
    date_curr = DateTime.current
    Ticket.where("created_time between ? and ?", date_from, date_to).each do |ticket|
      person = Person.find_by(id: ticket.person_id)
      if !person.nil?
        mailer_send = person.log_mailer_sends.find_or_initialize_by(crm_ticket_id: ticket.crm_ticket_id)
        puts "person_name: #{person.full_name}"

        if mailer_send.mails_count < 2 && !ticket.response_ivrs.present? && !ticket.response_surveys.present?
          
          if ticket.closed_time.present?
            if ticket.created_time.to_date == ticket.closed_time.to_date
              #ENVIAR MAIL
              #@person = person
              #AlertMailer.send_mail(person, "testing_unab").deliver_now
              mailer_send.mails_count += 1
              mailer_send.send_date = Date.current
              mailer_send.save
              puts "Mail enviado al ticket #{ticket.crm_ticket_id}"
            end
          end
          if mailer_send.mails_count == 1 && temp_alta
            if mailer_send.send_date.between?(date_curr, date_curr + 30.days)
              #ENVIAR MAIL
              #@person = person
              #AlertMailer.send_mail(person, "testing_unab").deliver_now
              mailer_send.mails_count += 1
              mailer_send.send_date = Date.current
              mailer_send.save
              puts "Mail enviado al ticket #{ticket.crm_ticket_id}"
            end

          elsif mailer_send.mails_count == 1 && temp_baja
            if mailer_send.send_date.between?(date_curr, date_curr + 15.days)
              #ENVIAR MAIL
              #@person = person
              #AlertMailer.send_mail(person, "testing_unab").deliver_now
              mailer_send.mails_count += 1
              mailer_send.send_date = Date.current
              mailer_send.save
              puts "Mail enviado al ticket #{ticket.crm_ticket_id}"
            end

          end
          
        end
      end
    end
    nil
  end

end

