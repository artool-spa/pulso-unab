class ResponseIvr < ApplicationRecord
  belongs_to :ticket
    
  def self.get_answer_from_ivr(from_date, to_date)
    @total_ivr_answers = 0
    ivr_api = UnabIvr.new
    from_date.upto(to_date) do |date|
      begin
        answer = JSON.parse(ivr_api.get_ivr_data(date).body)
        #puts "Date: #{date} Answer: #{answer} ".colorize(:light_green)
        #puts "--------------------------------".colorize(:light_blue)
        #answer = JSON.parse(ivr_api.get_ivr_data(date))
        answer["data"].each do |response|
          ResponseIvr.transaction do
            ticket = Ticket.find_by(crm_ticket_id: response["ticket_id"])
            if !ticket.nil?
              if !ticket.response_surveys.present?
                answer = ResponseIvr.find_or_initialize_by(ticket_id: ticket.id)
                #answer.ticket_id = response["ticket_id"]
                answer.crm_ticket_id = ticket.crm_ticket_id
                answer.income_channel = 'Call Center'
                answer.have_solution = response["answer"]
                option_1 = response["answer_details"].key?("option1") && response["answer_details"]["option1"].present? ? response["answer_details"]["option1"].to_i : nil
                #if option_1 == 1
                #  answer.option_1 = 'Sí'
                #elsif option_1 == 2
                #  answer.option_1 = 'No'
                #end 
                answer.option_2 = response["answer_details"].key?("option2") && response["answer_details"]["option2"].present? ? response["answer_details"]["option2"].to_i : nil
                answer.option_3 = response["answer_details"].key?("option3") && response["answer_details"]["option3"].present? ? response["answer_details"]["option3"].to_i : nil
                answer.option_4 = response["answer_details"].key?("option4") && response["answer_details"]["option4"].present? ? response["answer_details"]["option4"].to_i : nil
                if answer.option_4 == -1
                  answer.option_4 = nil
                end

                answer.date_created = date
                if answer.option_3 != -1  
                  answer.save
                end
                @total_ivr_answers += 1
                #if answer.persisted?
                #  @total_ivr_answers_save += 1
                #end
              end
            end
          end
          
        end
      rescue StandardError => error
        logger.debug{"Respuestas IVR error => Response: #{ivr_api.get_ivr_data(date).body}".colorize(:light_red)}
        puts "Respuestas IVR error => Response: #{ivr_api.get_ivr_data(date).body}".colorize(:light_red)
      end
    end
    puts "Respuestas IVR totales del periodo: #{@total_ivr_answers}"
    #puts "Respuestas IVR guardadas del periodo: #{@total_ivr_answers_save}"
    logger.debug{"Respuestas IVR totales del periodo => #{@total_ivr_answers}".colorize(:light_yellow)}
    #logger.debug{"Respuestas IVR guardadas del periodo => #{@total_ivr_answers_save}".colorize(:light_yellow)}
  end

  def self.set_income_ivr_channel
    ResponseIvr.all.each do |ivr|
      ivr.income_channel = 'Call Center'
      ivr.save
    end
  end

  def self.set_answers_ivr_to_null
    ResponseIvr.all.each do |ivr|
      if ivr.option_1 == -1
        ivr.option_1 = nil
        ivr.save
      end

      if ivr.option_2 == -1
        ivr.option_2 = nil
        ivr.save
      end

      if ivr.option_3 == -1
        ivr.option_3 = nil
        ivr.save
      end

      if ivr.option_4 == -1
        ivr.option_4 = nil
        ivr.save
      end

      if ivr.option_3.nil? && ivr.option_4.nil?
        ivr.destroy
      end

    end
  end

end
  