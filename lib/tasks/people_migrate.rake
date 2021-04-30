namespace :people_migrate do
  task :remap_tickets_people, [:debug_mode] => [:environment] do |t, args|
    date_curr = DateTime.current
    puts ">> Modificar person duplicado al original en tickets, #{date_curr.strftime("%F %T %z")}".colorize(:light_yellow)

    total_people_migrated, total_people_not_found = 0, 0
    same_people = []
    from_date = '2021-03-31'
    to_date = '2021-04-30'
    
    Ticket.where("created_time::date BETWEEN ? AND ?", from_date, to_date).each do |ticket|
      curr_person = Person.find_by(id: ticket.person_id)
      people = Person.where("rut LIKE ?", "%#{curr_person.rut[1..-1]}").order(id: :asc)
      people_count = people.count

      if people_count > 1
        original_person = people.first

        if (curr_person.id > original_person.id)        
          #puts "   ticket_id: #{ticket.id}, curr_person: #{curr_person.id} (#{curr_person.full_name}, #{curr_person.rut}) => original_person: #{original_person.id} (#{original_person.full_name}, #{original_person.rut})"

          ticket.person_id = original_person.id
          ticket.save
          total_people_migrated += 1
        else
          total_people_not_found += 1
          same_people << { ticket_id: ticket.id, people_id: curr_person.id } if (curr_person.id == original_person.id)
        end
      end
    end

    puts "   Termino el #{DateTime.current.strftime("%F %T %z")}, #{total_people_migrated} migrado(s), #{total_people_not_found} ya ok.".colorize(:light_yellow)
  end

  desc "Verificar peoples duplicados, con id mayor que los originales, que quedaron huerfanos despues de arrebatarles sus tickets"
  task :total_badly_created_people, [:debug_mode] => [:environment] do |t, args|
    date_curr = DateTime.current
    puts ">> Executing tickets:total_badly_created_people on #{date_curr.strftime("%F %T %z")}".colorize(:light_yellow)

    total_badly_created_people = []
    Person.includes(:tickets).where("created_at::date >= '2021-04-28'").each do |person|
      if person.tickets.count == 0
        total_badly_created_people << person
      end
    end

    puts "   Termino el #{DateTime.current.strftime("%F %T %z")}, #{total_badly_created_people.count} people viejos usados.".colorize(:light_yellow)
    
    total_badly_created_people.each do |v|
      puts " - person_id: #{v.id}, ticket_ids: #{v.tickets.map { |w| w.id }.inspect}".colorize(:light_black)
    end

    Person.where(id: total_badly_created_people.map { |v| v.id }).destroy_all
  end
end
