namespace :import do
    desc "Import excel file into DB"
    task extra_data: :environment do
      
        require 'roo'

        xlsx = Roo::Excelx.new("/home/ubuntu/pulso_unab/current/lib/tasks/Información complementaria.xlsx")

        # create table UNAB2020_extra_info (rut varchar(100), personal_email varchar(100), business_email varchar(100), unab_email varchar(100), name varchar(100), program_id varchar(100), program_desc varchar(100), campus_desc varchar(100), faculty_oai varchar(100), level_oai varchar(100), shift varchar(20), level varchar(100), modality varchar(100), student_level_desc varchar(100));

        enum = xlsx.sheet("Hoja1").each(id: 'ID (RUT)', personal_email: 'EMAIL_PARTICULAR', business_email: 'EMAIL_COMERCIAL', unab_email: 'EMAIL_UNAB', name: 'NAME', program_id: 'PROGRAM', program_desc: 'PROGRAM_DESC', campus_desc: 'CAMPUS_DESC', faculty_oai: 'FACULTAD_OAI', level_oai: 'NIVEL_OAI', shift: 'JORNADA', level: 'NIVEL', modality: 'MODALIDAD', student_level_desc: 'STUDENT_LEVEL_DESC')

        enum.drop(1).each do |hash|
            if !hash[:name].nil? && hash[:name].to_s.include?("'")
                hash[:name].to_s.sub! "'", "''"
            end

            if !hash[:personal_email].nil? && hash[:personal_email].to_s.include?("'")
                hash[:personal_email].to_s.sub! "'", "''"
            end

            query = "INSERT INTO UNAB2020_extra_info VALUES ('#{hash[:id]}', '#{hash[:personal_email]}', '#{hash[:business_email]}', '#{hash[:unab_email]}', '#{hash[:name]}', '#{hash[:program_id]}', '#{hash[:program_desc]}', '#{hash[:campus_desc]}', '#{hash[:faculty_oai]}', '#{hash[:level_oai]}', '#{hash[:shift]}', '#{hash[:level]}', '#{hash[:modality]}', '#{hash[:student_level_desc]}');"
            ActiveRecord::Base.connection.execute(query)
        end

        puts "--Task ended--"
      
    end
end