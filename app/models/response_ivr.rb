class ResponseIvr < ApplicationRecord
    belongs_to :ticket

    def self.get_answer_from_ivr(from_date, to_date)
      ivr_api = UnabIvr.new
      from_date.upto(to_date) do |date|
        
        answer = JSON.parse(ivr_api.get_ivr_data(date).body)
        puts "Date: #{date} Answer: #{answer} ".colorize(:light_green)
        puts "--------------------------------".colorize(:light_blue)
        #answer = JSON.parse(ivr_api.get_ivr_data(date))
        answer["data"].each do |response|
          ResponseIvr.transaction do
            ticket = Ticket.find_by(crm_ticket_id: response["ticket_id"])
            if !ticket.nil?
              answer = ResponseIvr.find_or_initialize_by(ticket_id: ticket.id)
              #answer.ticket_id = response["ticket_id"]
              answer.crm_ticket_id = ticket.crm_ticket_id
              answer.income_channel = "IVR"
              answer.have_solution = response["answer"]
              answer.option_1 = response["answer_details"]["option1"].present? ? response["answer_details"]["option1"].to_i : nil
              answer.option_2 = response["answer_details"]["option2"].present? ? response["answer_details"]["option2"].to_i : nil
              answer.option_3 = response["answer_details"]["option3"].present? ? response["answer_details"]["option3"].to_i : nil
              answer.option_4 = response["answer_details"]["option4"].present? ? response["answer_details"]["option4"].to_i : nil
              answer.date_created = date
              answer.save
              #if !answer.persisted?
              #  puts answer.errors.messages
              #end
            end
          end
        
        end
      end
    end
  
  end
  