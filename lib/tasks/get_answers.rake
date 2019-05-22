namespace :get_answers do
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

    ResponseSurvey.get_answers_from_survey(date_from, date_to)
    puts "Ending get answers from SM...".colorize(:light_yellow)
    ResponseQr.get_qr_answers_from_survey(date_from, date_to)
    puts "Ending get QR answers from SM...".colorize(:light_yellow)
    ResponseIvr.get_answer_from_ivr(date_from, date_to)
    puts "Ending get answers from IVR...".colorize(:light_yellow)
    end
end