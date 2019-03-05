class ResponseIvr < ApplicationRecord
    belongs_to :ticket

    def self.get_answer_from_ivr(from_date, to_date)
      ivr_api = UnabIvr.new
      from_date.upto(to_date) do |date|
        puts "date: #{date}"
        answer = JSON.parse(ivr_api.get_ivr_data(date).body)
        puts "answer: #{answer}"
        answer["data"].each do |response|
            ResponseIvr.transaction do
              puts "response: #{response}"
              ticket = Ticket.find_by(crm_ticket_id: response["ticket_id"])
              answer = Answer.find_or_initialize_by(ticket_id: ticket.id)
              #answer.ticket_id = response["ticket_id"]
              answer.crm_ticket_id = ticket.crm_ticket_id
              answer.income_channel = "IVR"
              answer.have_solution = response["answer"]
              answer.answer_details = response["answer_details"]
              answer.save
              if !answer.persisted?
                puts answer.errors.messages
              end

            end
        end
      end
    end
  
  end
  