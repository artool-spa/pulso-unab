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
      date_from = (date_curr - 2.days).beginning_of_day
      date_to = date_curr.end_of_day
    end
    date_from = date_from.in_time_zone('America/Santiago')
    date_to = date_to.in_time_zone('America/Santiago')

    Ticket.get_tickets_from_crm(date_from, date_to)
    puts "Ending get tickets from crm".colorize(:light_yellow)
    puts "------------------------------"
    Ticket.get_tickets_close_from_crm(date_from, date_to)
    puts "Ending get tickets closes from crm".colorize(:light_yellow)
    puts "------------------------------"
    end
end
  