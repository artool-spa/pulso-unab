namespace :import do
    desc "Pass data from an XLSX file to a CSV file generated in root "
    task address: :environment do
      
        require 'roo'

        xlsx = Roo::Excelx.new("../../Descargas/Clientes_Corp.xlsx")
        enum = xlsx.sheet("Base Clientes").each(calle: 'Calle', number: 'Número', commune: 'Comuna', region: 'Región')

        #headers = ['CALLE N° COMUNA REGIÓN']
        
        csv_data = CSV.generate(headers: false) do |csv|

            #csv << headers

            enum.drop(1).each do |hash|
                if !hash[:calle].blank? || !hash[:number].blank? || !hash[:commune].blank? || !hash[:region].blank?
                    if hash[:calle].to_s != '0'
                        if hash[:number].to_s.strip == '0' && hash[:calle].to_s.strip.include?("S/N")
                            address = hash[:calle].to_s.upcase.strip 
                        elsif hash[:number].to_s.strip == '0' && !hash[:calle].to_s.strip.include?("S/N")
                            address = hash[:calle].to_s.upcase.strip#+" S/N"
                        else
                            address = hash[:calle].to_s.upcase.strip+' '+hash[:number].to_s.strip
                        end
                        
                        commune = hash[:commune].to_s.upcase.strip
                        region = hash[:region].to_s.upcase.strip

                        string = ["#{address}, #{commune}, #{region}"]

                        csv << string
                    end
                end
            end
        end
        
        File.write("Direcciones-#{Date.today.to_s} sin SN.csv", csv_data)
        
        puts "--Task ended--"
      
    end
end
  