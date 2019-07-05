class ResponseSurvey < ApplicationRecord
  belongs_to :ticket

  def self.get_answers_from_survey(date_from, date_to)
    #curr_date = Date.current.strftime("%Y-%m-%d")
    # Encuesta via Mailing abiertas 
    ResponseSurvey.transaction do
      SurveyMonkeyArtoolApi::OpenAnswer.where(sm_survey_id: 173838967, date_range: "#{date_from} - #{date_to}").each do |answer_obj|
        ticket = Ticket.find_by(crm_ticket_id: answer_obj[:custom_variables][:ticket_id])
        if !ticket.nil?
          check_first_response = ticket.response_surveys.where(income_channel: "Mailing", sm_question_id: answer_obj[:sm_question_id]).count(:sm_question_id)
          if check_first_response == 0 && !ticket.response_ivrs.present?
            
            answer = ResponseSurvey.find_or_initialize_by(api_id: answer_obj[:id], answer_type: 'open')
            answer.ticket_id      = ticket.id
            answer.crm_ticket_id  = ticket.crm_ticket_id
            answer.question       = answer_obj[:heading]
            answer.answer         = answer_obj[:txt_response]
            #Categorizar respuesta de acuerdo al diccionario
            answer.sm_response_id = answer_obj[:sm_response_id] 
            answer.sm_question_id = answer_obj[:sm_question_id]
            answer.date_created   = answer_obj[:date_modified]
            answer.date_updated   = answer_obj[:updated_at]
            answer.income_channel = 'Mailing'
            puts "open answer: #{answer.question}"
            answer.save
            if !answer.persisted?
              puts answer.errors.messages
            end

          end
        end
        
      end
    end
    # Encuesta via Mailing selectivas
    ResponseSurvey.transaction do
      SurveyMonkeyArtoolApi::GradedAnswer.where(sm_survey_id: 173838967, date_range: "#{date_from} - #{date_to}").each do |graded|
        answer = ResponseSurvey.find_or_initialize_by(api_id: graded[:id], answer_type: 'graded')
        ticket = Ticket.find_by(crm_ticket_id: graded[:custom_variables][:ticket_id])
        if !ticket.nil?
          check_first_response = ticket.response_surveys.where(income_channel: "Mailing", sm_question_id: graded[:sm_question_id]).count(:sm_question_id)
          if check_first_response == 0 && !ticket.response_ivrs.present?
            answer.ticket_id      = ticket.id
            answer.crm_ticket_id  = ticket.crm_ticket_id       
            answer.question       = graded[:heading]
            answer.answer         = graded[:weight]

            if answer.present? && answer.answer.to_i > 5
              answer.satisfaction = 'Satisfecho'
            elsif answer.present? && answer.answer.to_i < 5
              answer.satisfaction = 'Insatisfecho'
            elsif answer.present? && answer.answer.to_i == 5
              answer.satisfaction = 'Neutro'
            end

            answer.sm_response_id = graded[:sm_response_id] 
            answer.sm_question_id = graded[:sm_question_id]
            answer.date_created   = graded[:date_modified]
            answer.date_updated   = graded[:updated_at]
            answer.income_channel = 'Mailing'
            puts "graded answer: #{answer.question}"
            answer.save
            if !answer.persisted?
              puts answer.errors.messages
            end
          end
        end
      end
    end

    # Encuesta via Totem Abierta
    ResponseSurvey.transaction do
      check = StringUtils.new
      global_rut = nil
      totem_answers = []
      answers_hash = Hash.new{}
      SurveyMonkeyArtoolApi::OpenAnswer.where(sm_survey_id: 173840981, date_range: "#{date_from} - #{date_to}").each do |opened|
        
        if opened[:sm_question_id] == 266251973
          rut = opened[:txt_response]
          global_rut = rut
          answers_hash[global_rut] = {:opened_id      => opened[:id],
                                      :sm_response_id => opened[:sm_response_id],
                                      :sm_question_id => opened[:sm_question_id],
                                      :question       => opened[:heading],
                                      :date_created   => opened[:date_modified],
                                      :date_updated   => opened[:updated_at]
                                     }
        elsif answers_hash[global_rut][:sm_response_id] == opened[:sm_response_id]
          question_id = opened[:sm_question_id].to_i
          open_ans = {  question_id => {
                          :opened_id      => opened[:id],
                          :answer         => opened[:txt_response],
                          :sm_response_id => opened[:sm_response_id],
                          :question       => opened[:heading],
                          :date_created   => opened[:date_modified],
                          :date_updated   => opened[:updated_at]
                        }
                      }
          
          answers_hash[global_rut].merge!(open_ans)
          
        end
        
      end
      graded_ans = {}
      SurveyMonkeyArtoolApi::GradedAnswer.where(sm_survey_id: 173840981, date_range: "#{date_from} - #{date_to}").each do |graded|
        grad = {
                  graded[:sm_response_id] => 
                      {
                        :graded_id      => graded[:id],
                        :question       => graded[:heading],
                        :answer         => graded[:weight],
                        :sm_question_id => graded[:sm_question_id],
                        :date_created   => graded[:date_modified],
                        :date_updated   => graded[:updated_at]
                      }
                }
        graded_ans.merge!(grad)
      end
      #associate graded answers with open answers
      answers_hash.each do |key, answer|
        if graded_ans[answer[:sm_response_id]].present?
          index = graded_ans[answer[:sm_response_id]][:sm_question_id]
          answer[index] = Hash.new
          answer[index].merge!(graded_ans[answer[:sm_response_id]])
        end
      end
      check = StringUtils.new

      answers_hash.each do |key, answer|
        global_rut = check.normalize_rut(key)
        if !global_rut.present?
          person = Person.find_by(rut: global_rut)
          
          if !person.present?
      
            answer_date = answer[:date_created]
            totem_ticket = associate_answer_to_ticket_totem(person, answer_date)
            if !totem_ticket.present?
              question_1 = answer[266254398]
              response = ResponseSurvey.find_or_initialize_by(api_id: question_1[:opened_id], answer_type: 'open')

              response.ticket_id      = totem_ticket.id      
              response.question       = question_1[:question]
              response.answer         = question_1[:answer]
              response.sm_response_id = question_1[:sm_response_id] 
              response.sm_question_id = 266254398
              response.crm_ticket_id  = totem_ticket.crm_ticket_id
              answer.date_created     = question_1[:date_created]   
              response.date_updated   = question_1[:updated_at]
              response.income_channel = 'Totem'
              puts "opened answer: #{answer.question}"
              byebug
              answer.save

              question_2 = answer[266254398]
              response = ResponseSurvey.find_or_initialize_by(api_id: question_2[:opened_id], answer_type: 'open')

              question_3 = answer[277856029]
              response = ResponseSurvey.find_or_initialize_by(api_id: question_3[:opened_id], answer_type: 'open')

              #question graded
              question_4 = answer[266259845]
              answer.ticket_id      = totem_ticket.id      
              answer.question       = opened[:heading]
              answer.answer         = opened[:txt_response]
              answer.sm_response_id = opened[:sm_response_id] 
              answer.sm_question_id = opened[:sm_question_id]
              answer.crm_ticket_id  = totem_ticket.crm_ticket_id
              answer.date_created   =  
              answer.date_updated   = opened[:updated_at]
              answer.income_channel = 'Totem'
              puts "opened answer: #{answer.question}"
              answer.save
            end
          end
        end
      end
=begin
        answer = ResponseSurvey.find_or_initialize_by(api_id: opened[:id], answer_type: 'open')
        if !check.normalize_rut(opened[:txt_response]).nil?
          rut = check.normalize_rut(opened[:txt_response])
          global_rut = rut
        end
        
        person = Person.find_by(rut: global_rut)            
        if !person.nil?   
          answer.date_created = opened[:date_modified]
          
          totem_ticket = associate_answer_to_ticket_totem(person, answer)
          
          if !totem_ticket.nil?
            answer.ticket_id      = totem_ticket.id      
            answer.question       = opened[:heading]
            answer.answer         = opened[:txt_response]
            answer.sm_response_id = opened[:sm_response_id] 
            answer.sm_question_id = opened[:sm_question_id]
            answer.crm_ticket_id  = totem_ticket.crm_ticket_id 
            answer.date_updated   = opened[:updated_at]
            answer.income_channel = 'Totem'
            puts "opened answer: #{answer.question}"
            answer.save
            if !answer.persisted?
              puts answer.errors.messages
            end
          end
        end
      end
=end
=begin
      # Encuesta via Totem Selectiva
      SurveyMonkeyArtoolApi::GradedAnswer.where(sm_survey_id: 173840981, date_range: "#{date_from} - #{date_to}").each do |graded|
        graded_answer = ResponseSurvey.find_or_initialize_by(api_id: graded[:id], answer_type: 'graded')
        
        person = Person.find_by(rut: global_rut)            
        if !person.nil?   
          graded_answer.date_created = graded[:date_modified]
          
          totem_ticket = associate_answer_to_ticket_totem(person, graded_answer)
          
          if !totem_ticket.nil?
            graded_answer.ticket_id      = totem_ticket.id
            graded_answer.crm_ticket_id  = totem_ticket.crm_ticket_id       
            graded_answer.question       = graded[:heading]
            graded_answer.answer         = graded[:weight]

            if graded_answer.present? && graded_answer.answer.to_i > 5
              graded_answer.satisfaction = 'Satisfecho'
            elsif graded_answer.present? && graded_answer.answer.to_i < 5
              graded_answer.satisfaction = 'Insatisfecho'
            elsif graded_answer.present? && graded_answer.answer.to_i == 5
              graded_answer.satisfaction = 'Neutro'
            end

            graded_answer.sm_response_id = graded[:sm_response_id] 
            graded_answer.sm_question_id = graded[:sm_question_id]
            graded_answer.date_created   = graded[:date_modified]
            graded_answer.date_updated   = graded[:updated_at]
            graded_answer.income_channel = 'Totem'
            puts "graded answer: #{graded_answer.question}"
            graded_answer.save
          end

        end
      end
=end
    end

  end
  
  def self.associate_answer_to_ticket_totem(person, answer_date)
    person.tickets.each do |ticket|
      if answer_date.to_date == ticket.created_time.to_date
        ticket_match = Ticket.find_by(id: ticket.id)
        
        return ticket_match
      end
    end
    return nil
  end

end
