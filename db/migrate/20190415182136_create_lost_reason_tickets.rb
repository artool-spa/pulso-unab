class CreateLostReasonTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :lost_reason_tickets do |t|
      t.string :crm_ticket_id, index: true
      t.text :lost_reason
      t.datetime :created_time, index: true
      t.datetime :updated_time, index: true
      t.timestamps
    end
  end
end
