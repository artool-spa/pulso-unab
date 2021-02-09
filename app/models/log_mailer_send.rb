class LogMailerSend < ApplicationRecord
  belongs_to :person
  @mail_send_count = 0
  @mail_send_errors = []

  def self.send_mail(date_from, date_to, debug)
    date_curr = DateTime.current

    Ticket.where("created_time::date between ? and ?", date_from, date_to).each do |ticket|
      temp_alta = false
      temp_baja = false

      person = Person.find_by(id: ticket.person_id)

      if person.present? && person.try(:email).present?
        if set_season_alta(ticket)
          temp_alta = true
        else
          temp_baja = true
        end

        # Find or Initialize LogMailerSend object
        mailer_send = person.log_mailer_sends.find_or_initialize_by(crm_ticket_id: ticket.crm_ticket_id)

        if !ticket.response_surveys.present? && mailer_send.mails_count < 2 #&& !ticket.response_ivrs.present?
          if ticket.income_channel.present? && ticket.income_channel.downcase.include?('web')
            if mailer_send.mails_count == 0
              #Via Web
              send_mail_to_person(person, mailer_send, ticket, debug)
              #puts "   Ticket via web"

            elsif mailer_send.mails_count == 1 && temp_baja && mailer_send.send_date + 15.days < date_curr
              #puts "   temp baja fechas: #{mailer_send.send_date.to_date} v/s #{date_curr.to_date}"
              send_mail_to_person(person, mailer_send, ticket, debug)

            elsif mailer_send.mails_count == 1 && temp_alta && mailer_send.send_date + 30.days < date_curr 
              #puts "   temp alta fechas: #{mailer_send.send_date.to_date} v/s #{date_curr.to_date}"
              send_mail_to_person(person, mailer_send, ticket, debug)
            end
        
          elsif ticket.close_first_line.downcase.include?('no') && ticket.created_time < date_curr - 1.week
            if mailer_send.mails_count == 0
              send_mail_to_person(person, mailer_send, ticket, debug)
            elsif mailer_send.mails_count == 1 && temp_alta && mailer_send.send_date + 30.days < date_curr 
              #puts "temp alta fechas: #{mailer_send.send_date.to_date} v/s #{date_curr.to_date}"
              send_mail_to_person(person, mailer_send, ticket, debug)
            elsif mailer_send.mails_count == 1 && temp_baja && mailer_send.send_date + 15.days < date_curr 
              #puts "temp baja fechas: #{mailer_send.send_date.to_date} v/s #{date_curr.to_date}"
              send_mail_to_person(person, mailer_send, ticket, debug)
            end

          # elsif mailer_send.mails_count == 0
          #   #Dont have answers 
          #   send_mail_to_person(person, mailer_send, ticket, debug)
          #   #puts "   Ticket sin respuesta"

          elsif mailer_send.mails_count == 1 && temp_alta && mailer_send.send_date + 30.days < date_curr 
            #puts "temp alta fechas: #{mailer_send.send_date.to_date} v/s #{date_curr.to_date}"
            send_mail_to_person(person, mailer_send, ticket, debug)

          elsif mailer_send.mails_count == 1 && temp_baja && mailer_send.send_date + 15.days < date_curr 
            #puts "temp baja fechas: #{mailer_send.send_date.to_date} v/s #{date_curr.to_date}"
            send_mail_to_person(person, mailer_send, ticket, debug)
          end
        end
      end
    end
    
    puts " - Total de Emails enviados efectivos: #{@mail_send_count}"

    mail_send_errors_count = @mail_send_errors.count
    if mail_send_errors_count > 0
      puts " - Total de Emails con errores: #{mail_send_errors_count}. Detalle a continuación:".colorize(:light_red)
      
      @mail_send_errors.each do |v|
        person = v[:person]
        error = v[:error]
        msg =  " - Person: #{person.full_name}, RUT: #{person.rut}, ID: #{person.id}, mail_send_counts: #{person.mail_send_counts}, mail_send_date: #{person.mail_send_date}" if person.is_a?(Person)
        msg += "   Error: #{error.message}".colorize(:light_black)
        puts msg
        # error.backtrace.grep_v(/\/gems\//).map { |l| l.gsub(`pwd`.strip + '/', '') }.each do |v|
        #   puts "     #{v.colorize(:light_black)}"
        # end
      end
    end
  end

  def self.send_mail_on_demand(ticket, tracker_id, custom_msg, debug)
    person = Person.find_by(id: ticket.person_id)

    if person.present? && person.try(:email).present?
      # Find or Initialize LogMailerSend object
      mailer_send = person.log_mailer_sends.find_or_initialize_by(crm_ticket_id: ticket.crm_ticket_id)

      send_mail_to_person(person, mailer_send, ticket, debug, tracker_id, custom_msg)
    end
  end

  private

    def self.send_mail_to_person(person, mailer_send, ticket, debug, tracker_id = "3VJGGWT", custom_msg = nil)
      begin
        if debug == 'false'
          AlertMailer.send_mail(person, ticket, "Evalúa Atención", custom_msg, tracker_id).deliver_now!
          @mail_send_count += 1
        else
          puts "Correo enviado con éxito a #{person.email}, ticket ID: #{ticket.id}"
        end

        mailer_send.mails_count += 1
        mailer_send.send_date = DateTime.current
        #mailer_send.send_date = rand(45.days).seconds.ago.to_date
        mailer_send.save

        puts " ! Cant save Mailer send: #{mailer_send.errors.full_messages}".colorize(:light_red) if !mailer_send.errors.empty?
        #puts "   Send mail to: #{ticket.crm_ticket_id} | person: #{person.full_name} | send_date: #{mailer_send.send_date}".colorize(:light_blue)
      rescue Exception => error
        @mail_send_errors << { person: person, error: error }
        puts " ! Error, ticket: #{ticket.crm_ticket_id}, person_id: #{person.id}, person_email: #{person.email}".colorize(:light_red)
      end
    end

    def self.set_season_alta(ticket)
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
