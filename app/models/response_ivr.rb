class ResponseIvr < ApplicationRecord
  belongs_to :ticket
    
  def self.get_answer_from_ivr(from_date, to_date)
    @total_ivr_answers = 0
    ivr_api = UnabIvr.new
    from_date.upto(to_date) do |date|
      begin
        answer = JSON.parse(ivr_api.get_ivr_data(date).body.gsub("\r",""))
        puts "Date: #{date} Answer: #{answer} ".colorize(:light_green)
        
        answer["data"].each do |response|     
          ResponseIvr.transaction do
            ticket = Ticket.find_by(crm_ticket_id: response["ticket_id"])
            if !ticket.nil?
              if !ticket.response_surveys.present?
                response_ivr = ResponseIvr.find_or_initialize_by(ticket_id: ticket.id)
                #response_ivr.ticket_id = response["ticket_id"]
                response_ivr.crm_ticket_id = ticket.crm_ticket_id
                response_ivr.income_channel = 'Call Center'
                response_ivr.have_solution = response["answer"]
                response_ivr.option_1 = response["answer_details"].key?("option1") && response["answer_details"]["option1"].present? ? response["answer_details"]["option1"].to_i : nil
                #if option_1 == 1
                #  response_ivr.option_1 = 'Sí'
                #elsif option_1 == 2
                #  response_ivr.option_1 = 'No'
                #end 
                response_ivr.option_2 = response["answer_details"].key?("option2") && response["answer_details"]["option2"].present? ? response["answer_details"]["option2"].to_i : nil
                response_ivr.option_3 = response["answer_details"].key?("option3") && response["answer_details"]["option3"].present? ? response["answer_details"]["option3"].to_i : nil
                response_ivr.option_4 = response["answer_details"].key?("option4") && response["answer_details"]["option4"].present? ? response["answer_details"]["option4"].to_i : nil
                
                if response_ivr.option_1 == -1
                  response_ivr.option_1 = nil
                elsif response_ivr.option_3 == -1
                  response_ivr.option_3 = nil
                elsif response_ivr.option_4 == -1
                  response_ivr.option_4 = nil
                end
                
                response_ivr.date_created = date

                if (response_ivr.option_1.present? && response_ivr.option_3.present? && response_ivr.option_4.present?)
                  response_ivr.save
                  @total_ivr_answers += 1
                end
                
                # if response_ivr.persisted?
                #  @total_ivr_answers_save += 1
                # end
              end
            end
          end
          
        end
      rescue StandardError => error
        puts "Respuestas IVR error => Response: #{ivr_api.get_ivr_data(date)}".colorize(:light_red)
        #AlertMailer.send_mail_err("Respuestas IVR error => Response: #{error}").deliver_now
      end
    end
    puts "Respuestas IVR totales del periodo: #{@total_ivr_answers}"
    AlertMailer.send_mail_err("Respuestas IVR totales: #{@total_ivr_answers} en el periodo #{from_date} | #{to_date}").deliver_now if @total_ivr_answers == 0
    #puts "Respuestas IVR guardadas del periodo: #{@total_ivr_answers_save}"
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

      if (ivr.option_1.nil? || ivr.option_3.nil? || ivr.option_4.nil?) 
        ivr.destroy
      end

    end
  end

end
  