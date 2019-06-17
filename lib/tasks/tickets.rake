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
      puts ">> Executing task from_date: #{date_from_crm} to_date: #{date_to_crm} debug_mode: #{args.debug_mode} only_tickets: #{args.only_tickets}"

      puts ">> Executing get_tickets task from_date: #{date_from_crm} to_date: #{date_to_crm}".colorize(:light_yellow)
      Ticket.get_tickets_from_crm(date_from_crm, date_to_crm)
      puts "Ending get tickets from crm".colorize(:light_yellow)
      puts "------------------------------"
      Ticket.get_tickets_close_from_crm(date_from_crm, date_to_crm)
      puts "Ending get tickets closes from crm".colorize(:light_yellow)
      if !args.only_tickets
        date_from = (date_curr - 3.days).beginning_of_day
        date_to = date_curr.end_of_day

        puts ">> Executing get_answers task from_date: #{date_from} to_date: #{date_to}".colorize(:light_yellow)
        ResponseSurvey.get_answers_from_survey(date_from, date_to)
        puts "   Ending get answers from SM...".colorize(:light_yellow)
        ResponseQr.get_qr_answers_from_survey(date_from, date_to)
        puts "   Ending get QR answers from SM...".colorize(:light_yellow)
        ResponseIvr.get_answer_from_ivr(date_from, date_to)
        puts "   Ending get answers from IVR...".colorize(:light_yellow)

        date_from = (date_curr - 35.days).beginning_of_day
        date_to = (date_curr + 1.days).end_of_day

        puts ">> Executing send_mail task from_date: #{date_from} to_date: #{date_to}".colorize(:light_yellow)
        
        LogMailerSend.send_mail(date_from, date_to, args.debug_mode)
        puts "   Ending send mails...".colorize(:light_yellow)
      end
    end
end
  