class Ticket < ApplicationRecord
  belongs_to :person
  has_many :mailers
  has_many :answers
  
  #@test_subject = Person.where(full_name: 'CRISTIAN MANUEL FERNANDEZ VASQUEZ').first
  #if @test_subject.full_name == 'CRISTIAN MANUEL FERNANDEZ VASQUEZ' && @test_subject.send_email == false
  #  AlertMailer.send_mail(@test_subject, "testing_unab").deliver_now
  #end
  @ticket_hash = {}

  def self.get_from_survey(ticket_hash)
    curr_date = Date.current.strftime("%Y-%m-%d")
    Answer.transaction do
      SurveyMonkeyArtoolApi::OpenAnswer.where(sm_survey_id: 165941594, date_range: "2019-01-01 - #{curr_date}").each do |answer_obj|
        answer = Answer.find_or_initialize_by(api_id: answer_obj[:id], answer_type: 'open')
        
        answer.ticket_id = ticket_hash[answer_obj[:custom_variables][:ticket_id]]
        answer.question = answer_obj[:heading]
        answer.answer = answer_obj[:txt_response]
        answer.sm_response_id = answer_obj[:sm_response_id] 
        answer.sm_question_id = answer_obj[:sm_question_id]
        answer.date_created = answer_obj[:created_at]
        answer.date_updated = answer_obj[:updated_at]
        answer.income_channel = 'Survey Monkey'
        answer.save
      end
    end

    Answer.transaction do
      SurveyMonkeyArtoolApi::GradedAnswer.where(sm_survey_id: 165941594, date_range: "2019-01-01 - #{curr_date}").each do |graded|
        answer = Answer.find_or_initialize_by(api_id: graded[:id], answer_type: 'graded')
        
        answer.ticket_id = ticket_hash[graded[:custom_variables][:ticket_id]]
        answer.question = graded[:heading]
        answer.answer = graded[:weight]
        answer.sm_response_id = graded[:sm_response_id] 
        answer.sm_question_id = graded[:sm_question_id]
        answer.date_created = graded[:created_at]
        answer.date_updated = graded[:updated_at]
        answer.income_channel = 'Survey Monkey'
        answer.save
      end
    end
  end

  def self.get_from_crm
    curr_date = Date.current.strftime("%Y-%m-%d")
    curr_date = '2018-11-14'
    unab_api = UnabApi.new
    check = StringUtils.new
    ticket_hash = {}
    
    unab_api.get_ticket_created(curr_date)[:casos_creados].each do |ticket_created|
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
    ticket_hash
  end

end

