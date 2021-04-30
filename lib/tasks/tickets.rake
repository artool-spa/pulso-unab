namespace :tickets do
  desc "Process tickets (; separator)"
  task :all, [:date_from, :date_to, :debug_mode, :only_tickets] => [:environment] do |t, args|
    args.with_defaults(date_from: nil, date_to: nil, debug_mode: false, only_tickets: false)

    date_curr = DateTime.now

    # Set initial retrieving period for stats
    if args.date_from.present? && args.date_to.present?
      date_from = DateTime.parse(args.date_from)
      date_to = DateTime.parse(args.date_to)
    else
      date_from = (date_curr - 2.days).beginning_of_day
      date_to = date_curr.end_of_day
    end

    # Correccion de los periodos locales para ser mostrados en UTC
    date_from = date_from.utc
    date_to = date_to.utc

    date_from_crm = date_from.to_date
    date_to_crm = date_to.to_date
    
    puts ">> Executing tickets:all on #{date_curr.iso8601}, date_from: #{date_from.iso8601}, date_to: #{date_to.iso8601}, only_tickets: #{args.only_tickets}, debug_mode: #{args.debug_mode}".colorize(:light_yellow)

    puts " * Executing Ticket.get_tickets_from_crm"
    Ticket.get_tickets_from_crm(date_from_crm, date_to_crm)
    
    puts " * Executing Ticket.get_tickets_close_from_crm"
    Ticket.get_tickets_close_from_crm(date_from_crm, date_to_crm)

    unless args.only_tickets
      date_from = (date_curr - 3.days).beginning_of_day
      date_to = date_curr.end_of_day

      # puts " * Executing get_answers task date_from: #{date_from} date_to: #{date_to}"
      # ResponseIvr.get_answer_from_ivr(date_from, date_to)

      puts " * Executing ResponseSurvey.get_answers_from_survey date_from: #{date_from.iso8601}, date_to: #{date_to.iso8601}"
      ResponseSurvey.get_answers_from_survey(date_from, date_to)
      
      puts " * Executing ResponseQr.get_qr_answers_from_survey date_from: #{date_from.iso8601}, date_to: #{date_to.iso8601}"
      ResponseQr.get_qr_answers_from_survey(date_from, date_to)

      date_from = (date_curr - 35.days).beginning_of_day
      date_to = (date_curr + 1.days).end_of_day

      puts " * Executing LogMailerSend.send_mail date_from: #{date_from.iso8601}, date_to: #{date_to.iso8601}"
      LogMailerSend.send_mail(date_from, date_to, args.debug_mode)
    end
    puts "   Ending process on #{DateTime.current.iso8601}".colorize(:light_yellow)
    
    #AlertMailer.send_mail_success("Mailing Unab ended").deliver_now
  end

  desc "Process tickets on demand (; separator)"
  task :on_demand, [:year, :month, :debug_mode] => [:environment] do |t, args|
    args.with_defaults(year: nil, month: nil, debug_mode: false)
    debug_mode = (args.debug_mode == 'true')
    date_curr = DateTime.current
    date_given = Date.new(args.year.to_i, args.month.to_i, 1)
    period_month = I18n.l(date_given, format: '%B').titleize

    puts ">> Executing LogMailerSend.send_mail_on_demand on #{date_curr} for period_month: #{period_month}".colorize(:light_yellow)

    sql_noviembre = %{
            SELECT p.id as person_id
            FROM tickets t
            JOIN people p ON(t.person_id = p.id)
            WHERE
              (t.created_time BETWEEN '2020-11-11 03:00:00' AND '2020-12-01 02:59:59')
              AND p.email IS NOT NULL
            GROUP BY p.id
            ORDER BY person_id ASC
    }

    # Tickets Query
    # sql = %{
    #   SELECT person_id, ticket_id, max_created_time
    #   FROM (
    #     SELECT p.rut, p.id as person_id, max(t.created_time) as max_created_time, max(t.id) as ticket_id, count(*)
    #     FROM tickets t
    #     JOIN people p ON(t.person_id = p.id)
    #     WHERE
    #       (t.created_time BETWEEN '2021-03-31 04:00:00' AND '2021-04-30 03:59:59')
    #       AND p.email IS NOT NULL
    #       AND p.rut != '17406837'
    #       AND person_id NOT IN(
    #         #{sql_noviembre}
    #       )
    #     GROUP BY p.rut, p.id
    #   ) as collection
    #   WHERE
    #   DATE_PART('year', max_created_time) = #{Arel.sql(args.year)} AND DATE_PART('month', max_created_time) = #{Arel.sql(args.month)}
    #   ORDER BY person_id ASC
    # }
    sql = %{
      SELECT MAX(person_id) max_person_id, MAX(rut) max_rut, email, MAX(ticket_id) max_ticket_id, MAX(max_created_time) max_max_created_time
      FROM (
        SELECT p.rut, p.id as person_id, p.email, max(t.created_time) as max_created_time, max(t.id) as ticket_id, count(*)
        FROM tickets t
        JOIN people p ON(t.person_id = p.id)
        WHERE
          (t.created_time BETWEEN '2021-03-31 04:00:00' AND '2021-04-30 03:59:59')
          AND p.email IS NOT NULL
          AND p.rut != '17406837'
        GROUP BY p.rut, p.id, p.email
      ) as collection
      WHERE
      DATE_PART('year', max_created_time) = #{Arel.sql(args.year)} AND DATE_PART('month', max_created_time) = #{Arel.sql(args.month)}
      GROUP BY email
      HAVING COUNT(*) > 1
      ORDER BY email ASC
    }
    
    results = ActiveRecord::Base.connection.exec_query(sql)
    results_count = results.count

    if debug_mode
      puts sql.colorize(:light_black)
      puts "results_count: #{results_count}"
      exit(1)
    end

    puts " ! Sin resultados de query sql".colorize(:light_red) if results_count == 0

    n_counter = 0
    results.each do |result|
      # Tracker y mensaje personalizado
      ticket = Ticket.find_by(id: result["ticket_id"])
      tracker_id = '3VJGGWT'
      custom_msg = <<-TXT
        Con el objetivo de conocer tu experiencia de #{period_month} en relacion a nuestro servicio y plataforma de atención, te invitamos a contestar una breve encuesta.
      TXT
      
      LogMailerSend.send_mail_on_demand(ticket, tracker_id, custom_msg, debug_mode)
      n_counter += 1
    end

    puts "   Ending process on #{DateTime.current.strftime("%F %T %z")}, #{n_counter}/#{results_count} sent".colorize(:light_yellow)
  
  end

  desc "Process tickets (; separator)"
  task :test_unab_api, [:date_from, :date_to, :debug_mode] => [:environment] do |t, args|
    args.with_defaults(date_from: nil, date_to: nil, debug_mode: false)

    date_curr = DateTime.current

    puts ">> Executing tickets:test_api on #{date_curr.strftime("%F %T %z")}".colorize(:light_yellow)

    unab_api = UnabApi.new
    tickets = unab_api.get_ticket_created("2021-02-10")[:casos_creados]
    tickets.each do |ticket|
      puts ticket.inspect
    end
  end
end
  