class LogMailerSend < ApplicationRecord
  belongs_to :person

  def self.send_mail(date_from, date_to)
    date_curr = DateTime.current
    Ticket.where("created_time::date between ? and ?", date_from, date_to).each do |ticket|
      temp_alta = false
      temp_baja = false
      person = Person.find_by(id: ticket.person_id)
      if !person.blank? && person.email.present?
        if set_season_alta(ticket)
          temp_alta = true
        else
          temp_baja = true
        end
        
        mailer_send = person.log_mailer_sends.find_or_initialize_by(crm_ticket_id: ticket.crm_ticket_id)
        if !ticket.response_ivrs.present? && !ticket.response_surveys.present? && mailer_send.mails_count < 2

          if ticket.income_channel.present? && ticket.income_channel.downcase == 'web'
            if mailer_send.mails_count == 0
              #Via Web
              send_mail_to_person(person, mailer_send, ticket)
              puts "   Ticket via web"
              
            elsif mailer_send.mails_count == 1 && temp_baja && mailer_send.send_date + 15.days < date_curr
              puts "   temp baja fechas: #{mailer_send.send_date.to_date} v/s #{date_curr.to_date}"
              send_mail_to_person(person, mailer_send, ticket)
              
            elsif mailer_send.mails_count == 1 && temp_alta && mailer_send.send_date + 30.days < date_curr 
              puts "   temp alta fechas: #{mailer_send.send_date.to_date} v/s #{date_curr.to_date}"
              send_mail_to_person(person, mailer_send, ticket)
            end
        
          else
            if mailer_send.mails_count == 0
              #Dont have answers 
              send_mail_to_person(person, mailer_send, ticket)
              puts "   Ticket sin respuesta"

            elsif mailer_send.mails_count == 1 && temp_alta && mailer_send.send_date + 30.days < date_curr 
              puts "temp alta fechas: #{mailer_send.send_date.to_date} v/s #{date_curr.to_date}"
              send_mail_to_person(person, mailer_send, ticket)

            elsif mailer_send.mails_count == 1 && temp_baja && mailer_send.send_date + 15.days < date_curr 
              puts "temp baja fechas: #{mailer_send.send_date.to_date} v/s #{date_curr.to_date}"
              send_mail_to_person(person, mailer_send, ticket)
            end
          end

        end
      end
    end
  
  end

  def send_mail_to_person(person, mailer_send, ticket)
    AlertMailer.send_mail(person, "Evalúa atención").deliver_now
    mailer_send.mails_count += 1
    mailer_send.send_date = DateTime.current
    #mailer_send.send_date = rand(45.days).seconds.ago.to_date
    mailer_send.save
    puts "   Send mail to: #{ticket.crm_ticket_id} | person: #{person.full_name} | send_date: #{mailer_send.send_date}".colorize(:light_blue)
  end

  def set_season_alta(ticket)
    if ticket.created_time.strftime("%B") == "December" || ticket.created_time.strftime("%B") == "January" || ticket.created_time.strftime("%B") == "February" || ticket.created_time.strftime("%B") == "March"
      true
    else
      false
    end
  end

=begin
  Meses de temporada alta:
    Dic
    Ene
    Feb
    Marzo

  Meses de temporada baja:
    Abril
    Mayo
    Junio
    Julio (*)
    Agosto
    Setiembre
    Octubre
    Noviembre
=end
    
end
