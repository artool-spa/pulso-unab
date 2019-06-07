namespace :careers do
    desc "Process tickets (; separator)"
    task :all, [:date_from, :date_to, :debug_mode] => [:environment] do |t, args|
      args.with_defaults(date_from: nil, date_to: nil, debug_mode: false)
      
      require 'roo'

      #xlsx = Roo::Spreadsheet.open('./new_prices.xlsx')
      xlsx = Roo::Excelx.new("../../Descargas/carreras.xlsx")
      count = 0
      # Use the extension option if the extension is ambiguous.
      xlsx.each(program: 'PROGRAMA', name: 'NOMBRE_PROGRAMA', time: 'JORNADA', type: "TIPO") do |hash|
        if count >= 1
          career = Career.find_or_initialize_by(program_id: hash[:program])
          career.name = hash[:name]
          career.time = hash[:time]
          career.type = hash[:type]
          career.save
        end
        count += 1
      end
      
      # => Returns basic info about the spreadsheet file
      
    end
end
  