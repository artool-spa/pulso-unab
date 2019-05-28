namespace :send_mail do
    desc "Process mails to"
    task :all, [:date_from, :date_to] => [:environment] do |t, args|
      args.with_defaults(date_from: nil, date_to: nil)

      date_curr = DateTime.current

      # Set initial retrieving period for stats
      if args.date_from.present? && args.date_to.present?
        date_from = DateTime.parse(args.date_from)
        date_to = DateTime.parse(args.date_to)
      else
        date_from = (date_curr - 35.days).beginning_of_day
        date_to = date_curr.end_of_day
      end
      puts ">> Executing send_mail task from_date: #{date_from} to_date: #{date_to}".colorize(:light_yellow)
      #person = Person.find_by(id: 10000003)
      #ticket = Ticket.find_by(crm_ticket_id: "CAS-21393-F1F2Y3")
      #mailer_send = person.log_mailer_sends.find_or_initialize_by(crm_ticket_id: ticket.crm_ticket_id)
      #send_mail_to_person(person, mailer_send, ticket)
      #exit(1)
      #byebug
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
          
          puts "   Temp_alta: #{temp_alta} | Temp_baja: #{temp_baja}".colorize(:light_yellow)
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
    def set_season_alta(ticket)
      if ticket.created_time.strftime("%B") == "December" || ticket.created_time.strftime("%B") == "January" || ticket.created_time.strftime("%B") == "February" || ticket.created_time.strftime("%B") == "March"
        true
      else
        false
      end
    end
end