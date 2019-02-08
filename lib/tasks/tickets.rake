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
    Ticket.get_from_survey
    Ticket.get_from_crm

    end  
end
  