namespace :tickets do
    desc "Process tickets (; separator)"
    task :all, [:date_from, :date_to] => [:environment] do |t, args|
      args.with_defaults(date_from: nil, date_to: nil)

    date_curr = DateTime.current

    # Set initial retrieving period for stats
    if args.date_from.present? && args.date_to.present?
      date_from = DateTime.parse(args.date_from)
      date_to = DateTime.parse(args.date_to)
    else
      date_from = date_curr.beginning_of_month
      date_to = date_curr
    end

    ticket_hash = Ticket.get_tickets_from_crm(date_from, date_to)
    puts "listo."
    Ticket.get_tickets_close_from_crm(date_from, date_to)
    puts "listo.."
    Answer.get_answers_from_survey(ticket_hash)
    puts "listo..."
    Answer.get_answer_from_ivr(date_from, date_to, ticket_hash)
    puts "listo...."
    end  
end
  