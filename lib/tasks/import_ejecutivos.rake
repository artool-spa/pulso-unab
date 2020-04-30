namespace :import do
    desc "Import excel file into DB"
    task ejecutivos: :environment do
      
        require 'roo'

        xlsx = Roo::Excelx.new("../../Descargas/Listado ejecutivos.xlsx")

        # create table ejecutivos (id_crm varchar(20), canal_ejecutivo varchar(20), nombre_ejecutivo varchar(20), sede varchar(20));

        xlsx.sheet("Lista ejecutivos7").each(id: 'ID nombre CRM', canal: 'Canal Ejecutivo UNAB', nombre: 'Nombre Ejecutivo UNAB', sede: 'SEDE') do |hash|

            query = "INSERT INTO ejecutivos VALUES ('#{hash[:id]}', '#{hash[:canal]}', '#{hash[:nombre]}', '#{hash[:sede]}');"

            puts query

            #ActiveRecord::Base.execute(query)
        end
      
      
    end
end
  