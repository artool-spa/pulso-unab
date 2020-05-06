namespace :import do
    desc "Import excel file into DB"
    task executives: :environment do
      
        require 'roo'

        xlsx = Roo::Excelx.new("/home/ubuntu/pulso_unab/current/lib/tasks/Listado ejecutivos.xlsx")

        #create table UNAB2020_executives (id_crm varchar(60), executive_channel varchar(60), executive_name varchar(60), hq varchar(60));

        enum = xlsx.sheet("Lista ejecutivos7").each(id: 'ID nombre CRM', channel: 'Canal Ejecutivo UNAB', name: 'Nombre Ejecutivo UNAB', hq: 'SEDE')

        enum.drop(1).each do |hash|
            query = "INSERT INTO UNAB2020_executives VALUES ('#{hash[:id]}', '#{hash[:channel]}', '#{hash[:name]}', '#{hash[:hq]}');"
            ActiveRecord::Base.connection.execute(query)
        end
      
        puts "--Task ended--"
      
    end
end
  