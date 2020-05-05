namespace :importer do
    desc "Import excel file into DB"
    task ejecutivos: :environment do
      
        require 'roo'

        xlsx = Roo::Excelx.new("../../Descargas/Listado ejecutivos.xlsx")

        # create table ejecutivos (id_crm varchar(60), canal_ejecutivo varchar(60), nombre_ejecutivo varchar(60), sede varchar(60));

        enum = xlsx.sheet("Lista ejecutivos7").each(id: 'ID nombre CRM', canal: 'Canal Ejecutivo UNAB', nombre: 'Nombre Ejecutivo UNAB', sede: 'SEDE')

        enum.drop(1).each do |hash|
            query = "INSERT INTO ejecutivos VALUES ('#{hash[:id]}', '#{hash[:canal]}', '#{hash[:nombre]}', '#{hash[:sede]}');"
            ActiveRecord::Base.connection.execute(query)
        end
      
        puts "--Task ended--"
      
    end
end
  