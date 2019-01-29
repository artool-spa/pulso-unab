class Ticket < ApplicationRecord
  belongs_to :person
  has_many :mailers
  has_many :answers

  def self.get_from_crm
    curr_date = Date.current.strftime("%Y-%m-%d")
    curr_date = '2018-11-14'
    unab_api = UnabApi.new
    unab_api.get_ticket_created(curr_date)[:casos_creados].each do |ticket_created|
      Person.transaction do
        person = Person.new
        person.full_name = ticket_created[:customerid]
        person.rut = ticket_created[:ctc_wa_rut]
        person.cellphone =  ticket_created[:ctc_mobilephone]
        person.phone = ticket_created[:ctc_telephone2]
        person.email = ticket_created[:ctc_emailaddress1]
        person.career = ticket_created[:mksv_carreraid]
        person.campus = ticket_created[:mksv_campusid]
        person.faculty = ticket_created[:prog_mksv_facultadid]
        person.send_email = false
        #check if there are fields 
        if unab_api.get_client_by_rut(person.rut)[:salida][:estado] == '1'
          if unab_api.get_client_by_rut(person.rut)[:contacto].kind_of?(Array)
            unab_api.get_client_by_rut(person.rut)[:contacto].each do |element|
              person.contact_id = element[:contactid]
            end 
          else
            contact_id = unab_api.get_client_by_rut(person.rut)[:contacto][:contactid]
            person.contact_id = contact_id
          end
        else
          person.contact_id = nil
        end

        person.save

        ticket = person.tickets.find_or_initialize_by(ticket_id: ticket_created[:ticketnumber])
        ticket.business_owner_unit = ticket_created[:mksv_unidaddenegociodelpropietarioid]
        ticket.business_author_unit = ticket_created[:mksv_unidaddenegociodelautorid]
                
        ticket.created_by = ticket_created[:createdby]
        ticket.owner_by = ticket_created[:ownerid]
        ticket.incident_id = ticket_created[:incidentid]

        ticket.income_channel = ticket_created[:mksv_canaldeingresoid]
        ticket.modify_by = ticket_created[:modifiedby]
        ticket.case_phase = ticket_created[:mksv_fasedelcasoname]
        ticket.category = ticket_created[:subjectid]
        ticket.state = ticket_created[:statecodename]
        ticket.status = ticket_created[:statuscodename]
        ticket.priority = ticket_created[:prioritycodename]
        ticket.case_type = ticket_created[ :casetypecodename]

        ticket.created_time = ticket_created[:createdonname].to_date
        ticket.updated_time = ticket_created[:modifiedonname].to_date

        ticket.save
      end
    end
    
  end
end

