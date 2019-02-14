class Answer < ApplicationRecord
  belongs_to :ticket

  def self.get_answers_from_survey(ticket_hash)
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

end
