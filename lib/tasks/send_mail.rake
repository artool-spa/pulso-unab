namespace :send_mail do
    desc "Process mails to"
    task :all, [:date_from, :date_to] => [:environment] do |t, args|
      args.with_defaults(date_from: nil, date_to: nil)

      date_curr = DateTime.current

      # Set initial retrieving period for stats
      if args.date_from.present? && args.date_to.present?
        date_from = DateTime.parse(args.date_from).strftime("%Y-%m-%d")
        date_to = DateTime.parse(args.date_to).strftime("%Y-%m-%d")
      else
        date_from = (date_curr - 1.days).strftime("%Y-%m-%d")
        date_to = date_curr.strftime("%Y-%m-%d")
      end
      temp_alta = set_season_alta()
      temp_baja = set_season_baja()
      
      Ticket.where("created_time::date between ? and ?", date_from, date_to).each do |ticket|
        
        person = Person.find_by(id: ticket.person_id)
        if !person.nil?
          mailer_send = person.log_mailer_sends.find_or_initialize_by(crm_ticket_id: ticket.crm_ticket_id)
          #puts "person_name: #{person.full_name}"
          if !ticket.response_ivrs.present? && !ticket.response_surveys.present? && mailer_send.mails_count < 2

            if ticket.income_channel.present? && ticket.income_channel.downcase == 'web'
              if mailer_send.mails_count == 0
                send_mail_to_person(person, mailer_send, ticket)
                puts "entro via web"
              elsif mailer_send.mails_count == 1 && temp_baja
                if mailer_send.send_date + 15.days < date_curr
                  puts "person_name: #{person.full_name}"
                  puts "temp alta fechas: #{mailer_send.send_date.to_date} v/s #{date_curr.to_date}"
                  send_mail_to_person(person, mailer_send, ticket)
                end
                
              elsif mailer_send.mails_count == 1 && temp_alta
                
                if mailer_send.send_date + 30.days < date_curr
                  puts "person_name: #{person.full_name}"
                  puts "temp alta fechas: #{mailer_send.send_date.to_date} v/s #{date_curr.to_date}"
                  send_mail_to_person(person, mailer_send, ticket)
                end

              elsif mailer_send.mails_count == 1 && temp_alta
                if mailer_send.send_date + 30.days < date_curr
                  puts "person_name: #{person.full_name}"
                  puts "temp alta fechas: #{mailer_send.send_date.to_date} v/s #{date_curr.to_date}"
                  send_mail_to_person(person, mailer_send, ticket)
                end

              elsif mailer_send.mails_count == 1 && temp_baja
                if mailer_send.send_date + 15.days < date_curr
                  puts "person_name: #{person.full_name}"
                  puts "temp baja fechas: #{mailer_send.send_date.to_date} v/s #{date_curr.to_date}"
                  send_mail_to_person(person, mailer_send, ticket)
                end
              end
          
            else
              if mailer_send.mails_count == 0 
                send_mail_to_person(person, mailer_send, ticket)
                puts "person_name: #{person.full_name}"
                puts "entro pq no tuvo respuesta alguna"
                #if ticket.closed_time.present?
                  #if ticket.created_time.to_date == ticket.closed_time.to_date
                    #send_mail_to_person(person, mailer_send, ticket)
                  #end
                #end

              elsif mailer_send.mails_count == 1 && temp_alta
                if mailer_send.send_date + 30.days < date_curr
                  puts "person_name: #{person.full_name}"
                  puts "temp alta fechas: #{mailer_send.send_date.to_date} v/s #{date_curr.to_date}"
                  send_mail_to_person(person, mailer_send, ticket)
                end

              elsif mailer_send.mails_count == 1 && temp_baja
                if mailer_send.send_date + 15.days < date_curr
                  puts "person_name: #{person.full_name}"
                  puts "temp baja fechas: #{mailer_send.send_date.to_date} v/s #{date_curr.to_date}"
                  send_mail_to_person(person, mailer_send, ticket)
                end
              end

            end

          end
        end
      end

    end
    
    def send_mail_to_person(person, mailer_send, ticket)
      
      #AlertMailer.send_mail(person, "testing_unab").deliver_now
      mailer_send.mails_count += 1
      mailer_send.send_date = Date.current
      #mailer_send.send_date = rand(45.days).seconds.ago.to_date
      mailer_send.save
      puts "Mail enviado al ticket #{ticket.crm_ticket_id}"
    end

    def set_season_alta()
      #temporada alta -> Enero - Marzo
      #Temporada baja -> Abril - Diciembre     
      date_current = DateTime.current
      year = date_current.year
      if date_current.between?("#{year}-01-01", "#{year}-03-31")
        true
      else
        false
      end
    end

    def set_season_baja()
      #temporada alta -> Enero - Marzo
      #Temporada baja -> Abril - Diciembre
      date_current = DateTime.current
      year = date_current.year
      if date_current.between?("#{year}-04-01", "#{year}-12-31")
        true
      else
        false
      end
    end
end