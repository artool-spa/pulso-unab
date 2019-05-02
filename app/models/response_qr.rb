class ResponseQr < ApplicationRecord
  
  def self.get_qr_answers_from_survey(date_from, date_to)
    # Encuesta via QR Baños Selectiva -- Abierta
    ResponseQr.transaction do
      SurveyMonkeyArtoolApi::GradedAnswer.where(sm_survey_id: 173798152, date_range: "#{date_from} - #{date_to}").each do |graded|
        answer = ResponseQr.find_or_initialize_by(api_id: graded[:id], answer_type: 'graded')
        answer.qr_value = qr_value
        answer.question = graded[:heading]
        answer.answer = graded[:weight]
        answer.sm_response_id = graded[:sm_response_id] 
        answer.sm_question_id = graded[:sm_question_id]
        answer.date_created = graded[:created_at]
        answer.date_updated = graded[:updated_at]
        puts "graded answer: #{answer.question}"
        answer.save
        #if !answer.persisted?
        #  puts answer.errors.messages
        #end
      end
      SurveyMonkeyArtoolApi::OpenAnswer.where(sm_survey_id: 173798152, date_range: "#{date_from} - #{date_to}").each do |graded|
        answer = ResponseQr.find_or_initialize_by(api_id: opened[:id], answer_type: 'opened')
        answer.qr_value = qr_value
        answer.question = opened[:heading]
        answer.answer = opened[:weight]
        answer.sm_response_id = opened[:sm_response_id] 
        answer.sm_question_id = opened[:sm_question_id]
        answer.date_created = opened[:created_at]
        answer.date_updated = opened[:updated_at]
        puts "opened answer: #{answer.question}"
        answer.save
        #if !answer.persisted?
        #  puts answer.errors.messages
        #end
      end
    end
  
    # Encuesta via QR Casino Selectiva -- Abierta
    ResponseQr.transaction do
      SurveyMonkeyArtoolApi::GradedAnswer.where(sm_survey_id: 173801696, date_range: "#{date_from} - #{date_to}").each do |graded|
        answer = ResponseQr.find_or_initialize_by(api_id: graded[:id], answer_type: 'graded')
        answer.qr_value = qr_value
        answer.question = graded[:heading]
        answer.answer = graded[:weight]
        answer.sm_response_id = graded[:sm_response_id] 
        answer.sm_question_id = graded[:sm_question_id]
        answer.date_created = graded[:created_at]
        answer.date_updated = graded[:updated_at]
        puts "graded answer: #{answer.question}"
        answer.save
        #if !answer.persisted?
        #  puts answer.errors.messages
        #end
      end  
      SurveyMonkeyArtoolApi::OpenAnswer.where(sm_survey_id: 173801696, date_range: "#{date_from} - #{date_to}").each do |graded|
        answer = ResponseQr.find_or_initialize_by(api_id: opened[:id], answer_type: 'opened')
        answer.qr_value = qr_value
        answer.question = opened[:heading]
        answer.answer = opened[:weight]
        answer.sm_response_id = opened[:sm_response_id] 
        answer.sm_question_id = opened[:sm_question_id]
        answer.date_created = opened[:created_at]
        answer.date_updated = opened[:updated_at]
        puts "opened answer: #{answer.question}"
        answer.save
        #if !answer.persisted?
        #  puts answer.errors.messages
        #end
      end
    end
  
    # Encuesta via QR Biblioteca Selectiva -- Abierta
    ResponseQr.transaction do
      SurveyMonkeyArtoolApi::GradedAnswer.where(sm_survey_id: 173802394, date_range: "#{date_from} - #{date_to}").each do |graded|
        answer = ResponseQr.find_or_initialize_by(api_id: graded[:id], answer_type: 'graded')
        answer.qr_value = qr_value
        answer.question = graded[:heading]
        answer.answer = graded[:weight]
        answer.sm_response_id = graded[:sm_response_id] 
        answer.sm_question_id = graded[:sm_question_id]
        answer.date_created = graded[:created_at]
        answer.date_updated = graded[:updated_at]
        puts "graded answer: #{answer.question}"
        answer.save
        #if !answer.persisted?
        #  puts answer.errors.messages
        #end
      end
      SurveyMonkeyArtoolApi::OpenAnswer.where(sm_survey_id: 173802394, date_range: "#{date_from} - #{date_to}").each do |graded|
        answer = ResponseQr.find_or_initialize_by(api_id: opened[:id], answer_type: 'opened')
        answer.qr_value = qr_value
        answer.question = opened[:heading]
        answer.answer = opened[:weight]
        answer.sm_response_id = opened[:sm_response_id] 
        answer.sm_question_id = opened[:sm_question_id]
        answer.date_created = opened[:created_at]
        answer.date_updated = opened[:updated_at]
        puts "opened answer: #{answer.question}"
        answer.save
        #if !answer.persisted?
        #  puts answer.errors.messages
        #end
      end
    end

  end

end
