class CreateTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :tickets do |t|
      t.string :crm_ticket_id, index: true
    
      t.string :business_owner_unit, index: true
      t.string :business_author_unit, index: true
      t.string :created_by
      t.string :owner_by
      
      t.string :incident_id
      t.string :income_channel, index: true

      t.string :modify_by
      t.string :case_phase, index: true
      
      t.string :category_1, index: true
      t.string :category_2, index: true
      t.string :category_3, index: true
      t.string :category_4, index: true
      
      t.integer :category_id, index: true

      t.string :state, index: true
      t.string :status, index: true
      t.string :priority, index: true
      t.string :case_type, index: true

      t.datetime :created_time, index: true
      t.datetime :updated_time, index: true
      t.datetime :closed_time, index: true
      t.integer :elapsed_time

      #t.integer :mail_send_counts, default: 0 
      #t.datetime :mail_send_date, default: nil
      
      t.references :person
      t.timestamps
    end
  end
end
