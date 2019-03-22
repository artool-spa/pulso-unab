class ResponseSurvey < ApplicationRecord
  belongs_to :ticket

  def self.get_answers_from_survey(date_from, date_to)
    #curr_date = Date.current.strftime("%Y-%m-%d")
    # Encuesta via Mailing abiertas 
    ResponseSurvey.transaction do
      SurveyMonkeyArtoolApi::OpenAnswer.where(sm_survey_id: 165941594, date_range: "#{date_from} - #{date_to}").each do |answer_obj|
        ticket = Ticket.find_by(crm_ticket_id: answer_obj[:custom_variables][:ticket_id])
        
        if !ticket.nil?
          answer = ResponseSurvey.find_or_initialize_by(api_id: answer_obj[:id], answer_type: 'open')
          answer.ticket_id = ticket.id
          answer.crm_ticket_id = ticket.crm_ticket_id
          answer.question = answer_obj[:heading]
          answer.answer = answer_obj[:txt_response]
          answer.sm_response_id = answer_obj[:sm_response_id] 
          answer.sm_question_id = answer_obj[:sm_question_id]
          answer.date_created = answer_obj[:created_at]
          answer.date_updated = answer_obj[:updated_at]
          answer.income_channel = 'Mailing'
          puts "open answer: #{answer.question}"
          answer.save
          #if !answer.persisted?
          #  puts answer.errors.messages
          #end
        end
        
      end
    end
    # Encuesta via Mailing selectivas
    ResponseSurvey.transaction do
      SurveyMonkeyArtoolApi::GradedAnswer.where(sm_survey_id: 165941594, date_range: "#{date_from} - #{date_to}").each do |graded|
        answer = ResponseSurvey.find_or_initialize_by(api_id: graded[:id], answer_type: 'graded')
        ticket = Ticket.find_by(crm_ticket_id: graded[:custom_variables][:ticket_id])
        
        if !ticket.nil?
          answer.ticket_id = ticket.id
          answer.crm_ticket_id = ticket.crm_ticket_id       
          answer.question = graded[:heading]
          answer.answer = graded[:weight]
          answer.sm_response_id = graded[:sm_response_id] 
          answer.sm_question_id = graded[:sm_question_id]
          answer.date_created = graded[:created_at]
          answer.date_updated = graded[:updated_at]
          answer.income_channel = 'Mailing'
          puts "graded answer: #{answer.question}"
          answer.save
          #if !answer.persisted?
          #  puts answer.errors.messages
          #end
        end

      end
    end
=begin
    # Encuesta via Totem selectivas
    ResponseSurvey.transaction do
      SurveyMonkeyArtoolApi::GradedAnswer.where(sm_survey_id: , date_range: "#{date_from} - #{date_to}").each do |graded|
        answer = ResponseSurvey.find_or_initialize_by(api_id: graded[:id], answer_type: 'graded')
        person = Person.find_by(rut: graded[:custom_variables][:rut])
        
        if !person.nil?
          answer.ticket_id = ticket.id
          answer.crm_ticket_id = ticket.crm_ticket_id       
          answer.question = graded[:heading]
          answer.answer = graded[:weight]
          answer.sm_response_id = graded[:sm_response_id] 
          answer.sm_question_id = graded[:sm_question_id]
          answer.date_created = graded[:created_at]
          answer.date_updated = graded[:updated_at]
          answer.income_channel = 'Totem'
          puts "graded answer: #{answer.question}"
          answer.save
          #if !answer.persisted?
          #  puts answer.errors.messages
          #end
        end

      end
    end

    # Encuesta via QR selectivas
    ResponseSurvey.transaction do
      SurveyMonkeyArtoolApi::GradedAnswer.where(sm_survey_id: , date_range: "#{date_from} - #{date_to}").each do |graded|
        answer = ResponseSurvey.find_or_initialize_by(api_id: graded[:id], answer_type: 'graded')
        person = Person.find_by(rut: graded[:custom_variables][:rut])
        
        if !person.nil?
          answer.ticket_id = ticket.id
          answer.crm_ticket_id = ticket.crm_ticket_id       
          answer.question = graded[:heading]
          answer.answer = graded[:weight]
          answer.sm_response_id = graded[:sm_response_id] 
          answer.sm_question_id = graded[:sm_question_id]
          answer.date_created = graded[:created_at]
          answer.date_updated = graded[:updated_at]
          answer.income_channel = 'QR'
          puts "graded answer: #{answer.question}"
          answer.save
          #if !answer.persisted?
          #  puts answer.errors.messages
          #end
        end

      end
    end
=end


  end

end
