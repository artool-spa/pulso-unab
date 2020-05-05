namespace :importer do
    desc "Import excel file into DB"
    task xlsx: :environment do
      
        require 'roo'

        xlsx = Roo::Excelx.new("../../Descargas/Información complementaria.xlsx")

        # create table complement (rut varchar(100), email_particular varchar(100), email_comercial varchar(100), email_unab varchar(100), name varchar(100),
        # program_id varchar(100), program_desc varchar(100), campus_desc varchar(100), facultad_oai varchar(100), nivel_oai varchar(100), jornada varchar(20),
        # nivel varchar(100), modalidad varchar(100), student_level_desc varchar(100));

        enum = xlsx.sheet("Hoja1").each(id: 'ID (RUT)', email_particular: 'EMAIL_PARTICULAR', email_comercial: 'EMAIL_COMERCIAL', email_unab: 'EMAIL_UNAB', name: 'NAME', program: 'PROGRAM', program_desc: 'PROGRAM_DESC', campus_desc: 'CAMPUS_DESC', facultad_oai: 'FACULTAD_OAI', nivel_oai: 'NIVEL_OAI', jornada: 'JORNADA', nivel: 'NIVEL', modalidad: 'MODALIDAD', student_level_desc: 'STUDENT_LEVEL_DESC')

        enum.drop(1).each do |hash|
            if !hash[:name].nil? && hash[:name].to_s.include?("'")
                hash[:name].to_s.sub! "'", "''"
            end

            if !hash[:email_particular].nil? && hash[:email_particular].to_s.include?("'")
                hash[:email_particular].to_s.sub! "'", "''"
            end

            query = "INSERT INTO complement VALUES ('#{hash[:id]}', '#{hash[:email_particular]}', '#{hash[:email_comercial]}', '#{hash[:email_unab]}', '#{hash[:name]}', '#{hash[:program]}', '#{hash[:program_desc]}', '#{hash[:campus_desc]}', '#{hash[:facultad_oai]}', '#{hash[:nivel_oai]}', '#{hash[:jornada]}', '#{hash[:nivel]}', '#{hash[:modalidad]}', '#{hash[:student_level_desc]}');"
            ActiveRecord::Base.connection.execute(query)
        end

        puts "--Task ended--"
      
    end
end