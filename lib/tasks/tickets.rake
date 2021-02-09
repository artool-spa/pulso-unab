namespace :tickets do
  desc "Process tickets (; separator)"
  task :all, [:date_from, :date_to, :debug_mode, :only_tickets] => [:environment] do |t, args|
    args.with_defaults(date_from: nil, date_to: nil, debug_mode: false, only_tickets: false)

    date_curr = DateTime.current

    # Set initial retrieving period for stats
    if args.date_from.present? && args.date_to.present?
      date_from = DateTime.parse(args.date_from)
      date_to = DateTime.parse(args.date_to)
    else
      date_from = (date_curr - 2.days).beginning_of_day
      date_to = date_curr.end_of_day
    end
    
    date_from_crm = date_from.to_date
    date_to_crm = date_to.to_date
    
    puts ">> Executing tickets:all on #{date_curr.strftime("%F %T %z")}, from_date: #{date_from_crm.strftime("%F %T %z")}, to_date: #{date_to_crm.strftime("%F %T %z")}, only_tickets: #{args.only_tickets}, debug_mode: #{args.debug_mode}".colorize(:light_yellow)
    # puts ">> Executing get_answers task from_date: #{date_from} to_date: #{date_to}".colorize(:light_yellow)
    # ResponseIvr.get_answer_from_ivr(date_from, date_to)
    # puts "   Ending get answers from IVR...".colorize(:light_yellow)

    puts " * Executing get_tickets_from_crm"
    Ticket.get_tickets_from_crm(date_from_crm, date_to_crm)
    
    puts " * Executing get_tickets_close_from_crm"
    Ticket.get_tickets_close_from_crm(date_from_crm, date_to_crm)

    if !args.only_tickets
      date_from = (date_curr - 3.days).beginning_of_day
      date_to = date_curr.end_of_day

      # puts " * Executing get_answers task from_date: #{date_from} to_date: #{date_to}"
      # ResponseIvr.get_answer_from_ivr(date_from, date_to)
      puts " * Executing get_answers_from_survey from_date: #{date_from.strftime("%F %T %z")} to_date: #{date_to.strftime("%F %T %z")}"
      ResponseSurvey.get_answers_from_survey(date_from, date_to)
      
      puts " * Executing get_qr_answers_from_survey from_date: #{date_from.strftime("%F %T %z")} to_date: #{date_to.strftime("%F %T %z")}"
      ResponseQr.get_qr_answers_from_survey(date_from, date_to)

      date_from = (date_curr - 35.days).beginning_of_day
      date_to = (date_curr + 1.days).end_of_day

      puts " * Executing LogMailerSend.send_mail from_date: #{date_from.strftime("%F %T %z")} to_date: #{date_to.strftime("%F %T %z")}"
      LogMailerSend.send_mail(date_from, date_to, args.debug_mode)
    end
    puts "   Ending process on #{DateTime.current.strftime("%F %T %z")}".colorize(:light_yellow)
    
    #AlertMailer.send_mail_success("Mailing Unab ended").deliver_now
  end

  desc "Process tickets on demand (; separator)"
  task :on_demand, [:date_from, :date_to, :debug_mode] => [:environment] do |t, args|
    args.with_defaults(date_from: nil, date_to: nil, debug_mode: false)
    date_curr = DateTime.current

    puts ">> Executing LogMailerSend.send_mail_on_demand on #{date_curr}".colorize(:light_yellow)

    # Tickets Query
    tickets = "" # Definir query de tickets

    tickets.each do |ticket|
      # Tracker y mensaje personalizado
      tracker_id = 'XZVMGCF'
      custom_msg = <<-TXT
        Con el objetivo de conocer tu experiencia en relacion a nuestro
        servicio y plataforma de atención, te invitamos a contestar una breve encuesta.
      TXT
      
      LogMailerSend.send_mail_on_demand(ticket, tracker_id, custom_msg, args.debug_mode)
    end

    puts "   Ending process on #{DateTime.current.strftime("%F %T %z")}".colorize(:light_yellow)
  end

  desc "Process tickets (; separator)"
  task :send, [:date_from, :date_to, :debug_mode] => [:environment] do |t, args|
    args.with_defaults(date_from: nil, date_to: nil, debug_mode: false)

    date_curr = DateTime.current

    puts ">> Executing tickets:send on #{date_curr.strftime("%F %T %z")}, from_date: #{date_from} to_date: #{date_to} debug_mode: #{args.debug_mode}".colorize(:light_yellow)

    date_from = (date_curr - 35.days).beginning_of_day
    date_to = (date_curr + 1.days).end_of_day

    LogMailerSend.send_mail(date_from, date_to, args.debug_mode)
    puts "   Ending process on #{DateTime.current.strftime("%F %T %z")}".colorize(:light_yellow)
    
    #AlertMailer.send_mail_success("Mailing Unab ended").deliver_now
  end
end
  