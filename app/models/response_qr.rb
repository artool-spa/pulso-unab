class ResponseQr < ApplicationRecord
  
  def self.get_qr_answers_from_survey(date_from, date_to)
    # Encuesta via QR Baños Selectiva -- Abierta
    ResponseQr.transaction do
      SurveyMonkeyArtoolApi::GradedAnswer.where(sm_survey_id: 173798152, date_range: "#{date_from} - #{date_to}").each do |graded|
        answer = ResponseQr.find_or_initialize_by(api_id: graded[:id], answer_type: 'graded')
        #answer.qr_code = graded[:id]
        answer.question = graded[:heading]
        answer.answer = graded[:weight]
        answer.sm_response_id = graded[:sm_response_id] 
        answer.sm_question_id = graded[:sm_question_id]
        answer.date_created = graded[:created_at]
        answer.date_updated = graded[:updated_at]
        if answer.present? && answer.answer.to_i > 5
          answer.satisfaction = 'Satisfecho'
        elsif answer.present? && answer.answer.to_i < 5
          answer.satisfaction = 'Insatisfecho'
        elsif answer.present? && answer.answer.to_i == 5
          answer.satisfaction = 'Neutro'
        end
        puts "Baños graded question: #{graded[:heading]} | answer: #{graded[:weight]}".colorize(:light_green)
        answer.save
        #if !answer.persisted?
        #  puts answer.errors.messages
        #end
      end
      SurveyMonkeyArtoolApi::OpenAnswer.where(sm_survey_id: 173798152, date_range: "#{date_from} - #{date_to}").each do |opened|
        answer = ResponseQr.find_or_initialize_by(api_id: opened[:id], answer_type: 'opened')
        #answer.qr_code = opened[:id]
        answer.question = opened[:heading]
        answer.answer = opened[:txt_response]
        answer.sm_response_id = opened[:sm_response_id] 
        answer.sm_question_id = opened[:sm_question_id]
        answer.date_created = opened[:created_at]
        answer.date_updated = opened[:updated_at]
        puts "Baños opened question: #{opened[:heading]} | opened answer: #{opened[:txt_response]}".colorize(:light_blue)
        puts "-------------------------------".colorize(:light_yellow)
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
        #answer.qr_code = graded[:id]
        answer.question = graded[:heading]
        answer.answer = graded[:weight]
        answer.sm_response_id = graded[:sm_response_id] 
        answer.sm_question_id = graded[:sm_question_id]
        answer.date_created = graded[:created_at]
        answer.date_updated = graded[:updated_at]

        if answer.present? && answer.answer.to_i > 5
          answer.satisfaction = 'Satisfecho'
        elsif answer.present? && answer.answer.to_i < 5
          answer.satisfaction = 'Insatisfecho'
        elsif answer.present? && answer.answer.to_i == 5
          answer.satisfaction = 'Neutro'
        end
        puts "Casino graded question: #{graded[:heading]} | answer: #{graded[:weight]}".colorize(:light_green)
        answer.save
        #if !answer.persisted?
        #  puts answer.errors.messages
        #end
      end  
      SurveyMonkeyArtoolApi::OpenAnswer.where(sm_survey_id: 173801696, date_range: "#{date_from} - #{date_to}").each do |opened|
        answer = ResponseQr.find_or_initialize_by(api_id: opened[:id], answer_type: 'opened')
        #answer.qr_code = opened[:id]
        answer.question = opened[:heading]
        answer.answer = opened[:txt_response]
        answer.sm_response_id = opened[:sm_response_id] 
        answer.sm_question_id = opened[:sm_question_id]
        answer.date_created = opened[:created_at]
        answer.date_updated = opened[:updated_at]
        puts "Casino opened question: #{opened[:heading]} | opened answer: #{opened[:txt_response]}".colorize(:light_blue)
        puts "-------------------------------".colorize(:light_yellow)
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
        #answer.qr_code = graded[:id]
        answer.question = graded[:heading]
        answer.answer = graded[:weight]
        answer.sm_response_id = graded[:sm_response_id] 
        answer.sm_question_id = graded[:sm_question_id]
        answer.date_created = graded[:created_at]
        answer.date_updated = graded[:updated_at]
        if answer.present? && answer.answer.to_i > 5
          answer.satisfaction = 'Satisfecho'
        elsif answer.present? && answer.answer.to_i < 5
          answer.satisfaction = 'Insatisfecho'
        elsif answer.present? && answer.answer.to_i == 5
          answer.satisfaction = 'Neutro'
        end
        puts "Biblio graded question: #{graded[:heading]} | answer: #{graded[:weight]}".colorize(:light_green)
        answer.save
        #if !answer.persisted?
        #  puts answer.errors.messages
        #end
      end
      SurveyMonkeyArtoolApi::OpenAnswer.where(sm_survey_id: 173802394, date_range: "#{date_from} - #{date_to}").each do |opened|
        answer = ResponseQr.find_or_initialize_by(api_id: opened[:id], answer_type: 'opened')
        #answer.qr_code = opened[:id]
        answer.question = opened[:heading]
        answer.answer = opened[:txt_response]
        answer.sm_response_id = opened[:sm_response_id] 
        answer.sm_question_id = opened[:sm_question_id]
        answer.date_created = opened[:created_at]
        answer.date_updated = opened[:updated_at]
        puts "Biblio opened question: #{opened[:heading]} | opened answer: #{opened[:txt_response]}".colorize(:light_blue)
        puts "-------------------------------".colorize(:light_yellow)
        answer.save
        #if !answer.persisted?
        #  puts answer.errors.messages
        #end
      end
    end

  end

end
