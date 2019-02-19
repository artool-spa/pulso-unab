class Ticket < ApplicationRecord
  belongs_to :person
  has_many :mailers
  has_many :answers
  
  #@test_subject = Person.where(full_name: 'CRISTIAN MANUEL FERNANDEZ VASQUEZ').first
  #if @test_subject.full_name == 'CRISTIAN MANUEL FERNANDEZ VASQUEZ' && @test_subject.send_email == false
  #  AlertMailer.send_mail(@test_subject, "testing_unab").deliver_now
  #end
  @ticket_hash = {}

  def self.get_tickets_from_crm(from_date, to_date)
    curr_date = Date.current.strftime("%Y-%m-%d")
    curr_date = '2018-11-14'
    unab_api = UnabApi.new
    check = StringUtils.new
    ticket_hash = {}
    from_date.upto(to_date) do |date|
      date = date.strftime("%Y-%m-%d")
      unab_api.get_ticket_created(date)[:casos_creados].each do |ticket_created|
        Person.transaction do
          person = Person.find_or_initialize_by(rut: ticket_created[:ctc_wa_rut])
          person.full_name = ticket_created[:customerid]
          person.cellphone =  check.normalize_phone(ticket_created[:ctc_mobilephone])
          person.phone = check.normalize_phone(ticket_created[:ctc_telephone2])
          person.email = check.normalize_mail(ticket_created[:ctc_emailaddress1])
          person.career = ticket_created[:mksv_carreraid]
          person.campus = ticket_created[:mksv_campusid]
          person.faculty = ticket_created[:prog_mksv_facultadid]
          person.send_email = false
          
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
  
          ticket.created_time = ticket_created[:createdonname].to_date
          ticket.updated_time = ticket_created[:modifiedonname].to_date
  
          ticket.save
          puts "ticket guardado fecha: #{date}"
          ticket_hash[ticket.crm_ticket_id] = ticket.id
          
  
          mailer_send = person.log_mailer_sends.find_or_initialize_by(person_id: person.id)
          mailer_send.had_answer = false
          mailer_send.save
  
          #if person.id == 2
          #  @person = person
          #  AlertMailer.send_mail(@person, "testing_unab").deliver_now
          #  person.send_email = true
          #  person.save
          #end
        end
      end      
    end
    ticket_hash
  end

end

