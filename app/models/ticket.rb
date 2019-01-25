class Ticket < ApplicationRecord
  belongs_to :person
  has_many :mailers
  has_many :answers

  def self.get_from_crm
    curr_date = Date.current.strftime("%Y-%m-%d")
    curr_date = '2018-11-14'
    
    unab_api = UnabApi.new
    ticket = Ticket.new
    unab_api.get_ticket_created(curr_date)[:casos_creados].each do |ticket_created|
      Ticket.transaction do
        #ticket.business_owner_unit = ticket_created[:mksv_unidaddenegociodelpropietarioid]
        #ticket.business_author_unit = ticket_created[:mksv_unidaddenegociodelpropietarioid]
        
        ticket.author = ticket_created[:createdby]
        ticket.owner = ticket_created[:ownerid]
        ticket.created_time = ticket_created[:createdonname].to_date
        ticket.updated_time = ticket_created[:modifiedonname].to_date
        ticket.campus = ticket_created[:mksv_campusid]
        ticket.career = ticket_created[:mksv_carreraid]
        ticket.modify_by = ticket_created[:modifiedby]
        ticket.case_phase = ticket_created[:mksv_fasedelcasoname]
        #ticket.category = ticket_created[:mksv_unidaddenegociodelpropietarioid]
        #ticket.contact = ticket_created[:mksv_unidaddenegociodelpropietarioid]
        ticket.state = ticket_created[:statecodename]
        ticket.status = ticket_created[:statuscodename]
        ticket.priority = ticket_created[:prioritycodename]
        ticket.case_type = ticket_created[ :casetypecodename]
        ticket.have_answer = ticket_created[:mksv_unidaddenegociodelpropietarioid]
        ticket.faculty = ticket_created[:prog_mksv_facultadid]
        ticket.save
      end
    end
  end
end
