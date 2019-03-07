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
      temp_alta = false
      temp_baja = true
      
      Ticket.where("created_time between ? and ?", date_from, date_to).each do |ticket|
        person = Person.find_by(id: ticket.person_id)
        if !person.nil?
          mailer_send = person.log_mailer_sends.find_or_initialize_by(crm_ticket_id: ticket.crm_ticket_id)
          puts "person_name: #{person.full_name}"
          
          if mailer_send.mails_count < 2 && !ticket.response_ivrs.present? && !ticket.response_surveys.present?
            
            if ticket.closed_time.present?
              if ticket.created_time.to_date == ticket.closed_time.to_date
                #ENVIAR MAIL
                #@person = person
                #AlertMailer.send_mail(person, "testing_unab").deliver_now
                mailer_send.mails_count += 1
                mailer_send.send_date = Date.current
                mailer_send.save
                puts "Mail enviado al ticket #{ticket.crm_ticket_id}"
              end
            end
            if mailer_send.mails_count == 0
              #ENVIAR MAIL
              #@person = person
              #AlertMailer.send_mail(person, "testing_unab").deliver_now
              mailer_send.mails_count += 1
              mailer_send.send_date = Date.current - 15.days
              mailer_send.save
              puts "Mail enviado al ticket #{ticket.crm_ticket_id}"  
            
            elsif mailer_send.mails_count == 1 && temp_alta
              if mailer_send.send_date.between?(date_curr - 32.days, date_curr)
                #ENVIAR MAIL
                #@person = person
                #AlertMailer.send_mail(person, "testing_unab").deliver_now
                mailer_send.mails_count += 1
                mailer_send.send_date = Date.current
                mailer_send.save
                puts "Mail enviado al ticket #{ticket.crm_ticket_id}"
              end

            elsif mailer_send.mails_count == 1 && temp_baja
              if mailer_send.send_date.between?(date_curr - 17.days, date_curr)
                #ENVIAR MAIL
                #@person = person
                #AlertMailer.send_mail(person, "testing_unab").deliver_now
                mailer_send.mails_count += 1
                mailer_send.send_date = Date.current
                mailer_send.save
                puts "Mail enviado al ticket #{ticket.crm_ticket_id}"
              end

            end
            
          end
        end
      end

    end
end