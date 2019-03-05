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
      date_from = (date_curr - 1.days).strftime("%Y-%m-%d")
      date_to = date_curr.strftime("%Y-%m-%d")
    end
    Ticket.all.where("created_time between '%#{date_from}%' and '%#{date_to}%'").each do |ticket|
      
      person = Person.all.find(id = ticket.person_id)
      
      if !ticket.response_ivrs.present? && !ticket.response_surveys.present? && ticket.closed_time.present?
        #Si un ticket se abre, deriva y cierra todo en un mismo día, 
        #y a su vez no se reciben respuestas mediante IVR ni TOTEM, 
        #entonces a esa persona se le enviará un email con la encuesta.
        if ticket.created_time.to_date == ticket.closed_time.to_date
          #ENVIAR MAIL
          #@person = person
          #AlertMailer.send_mail(person, "testing_unab").deliver_now
          mailer_send = person.log_mailer_sends.find_or_initialize_by(crm_ticket_id: ticket.crm_ticket_id)
          mailer_send.mails_count += 1
          mailer_send.send_date = Date.current
          #mailer_send.save
          puts "Mail enviado al ticket #{ticket.crm_ticket_id}"
        end
      else
        #puts "Tiene respuesta"
=begin        
        #Enviar mail evaluando la ultima vez que se mando mail
        ticket.mail_send_counts += 1
        ticket.mail_send_date = Date.current 
        mailer_send = person.log_mailer_sends.find_or_initialize_by(crm_ticket_id: ticket.crm_ticket_id)
        mailer_send.mails_count += 1
        mailer_send.send_date = Date.current
        
        #log_mailer = LogMailerSend.find_or_initialize_by(api_id: answer_obj[:id], answer_type: 'open')
        ticket.save
        mailer_send.save
     
      else
        #Temporada baja: si han pasado mas de 15 dias del ultimo envio, se envia mail
        #Temporada alta: si han pasado mas de 30 dias del ultimo envio, se envia mail
        ticket.answers.each do |answer|
          if temp_baja
            if !ticket.mail_send_date.between?(Date.current - 15.days, Date.current)
              #enviar correo
            end
          else #temp_alta
            if !ticket.mail_send_date.between?(Date.current - 30.days, Date.current)
              #enviar correo
            end
          end

        end
=end 
      end

    end

    end  
end