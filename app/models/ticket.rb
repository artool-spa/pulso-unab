class Ticket < ApplicationRecord
  belongs_to :person
  has_many :mailers
  #has_many :answers
  
  @test_subject = Person.where(full_name: 'CRISTIAN MANUEL FERNANDEZ VASQUEZ').first
  if @test_subject.full_name == 'CRISTIAN MANUEL FERNANDEZ VASQUEZ' && @test_subject.send_email == false
    AlertMailer.exception_msg(@test_subject, "testing_unab").deliver_now
  end
  byebug
  def self.get_from_survey
    curr_date = Date.current.strftime("%Y-%m-%d")
    SurveyMonkeyArtoolApi::OpenAnswer.where(sm_survey_id: 165941594, date_range: "2019-01-01 - #{curr_date}").each do |answer_obj|
      
      Answer.transaction do
        answer = Answer.new
        answer.question = answer_obj[:heading]
        answer.answer = answer_obj[:txt_response]
        answer.sm_response_id = answer_obj[:sm_response_id]
        answer.sm_question_id = answer_obj[:sm_question_id]
        answer.date_created = answer_obj[:created_at]
        answer.date_updated = answer_obj[:updated_at]
        answer.income_channel = 'Survey Monkey'
        answer.save
        #byebug
      end
    end
    SurveyMonkeyArtoolApi::GradedAnswer.where(sm_survey_id: 165941594, date_range: "2019-01-01 - #{curr_date}").each do |graded|
      Answer.transaction do
        answer = Answer.new
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
    unab_api.get_ticket_created(curr_date)[:casos_creados].each do |ticket_created|
      Person.transaction do
        person = Person.new
        person.full_name = ticket_created[:customerid]
        rut = ticket_created[:ctc_wa_rut]
        person.rut = check.normalize_rut(rut)
        person.cellphone =  check.normalize_phone(ticket_created[:ctc_mobilephone])
        person.phone = check.normalize_phone(ticket_created[:ctc_telephone2])
        puts "Phone: #{ticket_created[:ctc_telephone2]}"
        puts "Phone_modify: #{person.phone}"
        person.email = check.normalize_mail(ticket_created[:ctc_emailaddress1])
        person.career = ticket_created[:mksv_carreraid]
        person.campus = ticket_created[:mksv_campusid]
        person.faculty = ticket_created[:prog_mksv_facultadid]
        person.send_email = false
        
        #check if there are fields 
        if unab_api.get_client_by_rut(rut)[:salida][:estado] == '1'
          if unab_api.get_client_by_rut(rut)[:contacto].kind_of?(Array)
            unab_api.get_client_by_rut(rut)[:contacto].each do |element|
              person.contact_id = element[:contactid]
            end 
          else
            contact_id = unab_api.get_client_by_rut(rut)[:contacto][:contactid]
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

        #answer = ticket.answers.find_or_initialize_by(crm_ticket_id: ticket.crm_ticket_id)
        mailer_send = person.log_mailer_sends.find_or_initialize_by(mails_count: 0)
        mailer_send.had_answer = false
        mailer_send.save
      end
    end
    
  end
end

