namespace :importer do
    desc "Import excel file into DB"
    task xlsx: :environment do
      
        require 'roo'

        xlsx = Roo::Excelx.new("../../Descargas/Información complementaria.xlsx")

        # create table complement (rut varchar(20), email_particular varchar(20), email_comercial varchar(20), email_unab varchar(20), 
        # name varchar(20), program_id varchar(10), program_desc varchar(20), campus_desc varchar(20), facultad_oai varchar(20), 
        # nivel_oai varchar(20), jornada varchar(20), nivel varchar(20), modalidad varchar(20), student_level_desc varchar(30));

        enum = xlsx.sheet("Hoja1").each(id: 'ID (RUT)', email_particular: 'EMAIL_PARTICULAR', email_comercial: 'EMAIL_COMERCIAL', email_unab: 'EMAIL_UNAB', name: 'NAME', program: 'PROGRAM', program_desc: 'PROGRAM_DESC', campus_desc: 'CAMPUS_DESC', facultad_oai: 'FACULTAD_OAI', nivel_oai: 'NIVEL_OAI', jornada: 'JORNADA', nivel: 'NIVEL', modalidad: 'MODALIDAD', student_level_desc: 'STUDENT_LEVEL_DESC')

        enum.drop(1).each do |hash|
            query = "INSERT INTO complement VALUES ('#{hash[:id]}', '#{hash[:email_particular]}', '#{hash[:email_comercial]}', '#{hash[:email_unab]}', '#{hash[:name]}', '#{hash[:program]}', '#{hash[:program_desc]}', '#{hash[:campus_desc]}', '#{hash[:facultad_oai]}', '#{hash[:nivel_oai]}', '#{hash[:jornada]}', '#{hash[:nivel]}', '#{hash[:modalidad]}', '#{hash[:student_level_desc]}');"
            
            ActiveRecord::Base.connection.execute(query)
        end

        puts "--Task ended--"
      
    end
end