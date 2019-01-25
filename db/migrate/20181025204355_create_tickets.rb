class CreateTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :tickets do |t|
      t.integer :ticket_id, index: true
    
      t.integer :business_owner_unit, index: true
      t.integer :business_author_unit, index: true
      t.string :author
      t.string :owner
      t.datetime :created_time, index: true
      t.datetime :updated_time, index: true
      t.string :campus
      t.string :career
      t.string :modify_by
      t.string :case_phase
      t.string :category
      t.string :contact

      #t.integer :state_code, index: true
      #t.integer :status_code, index:true
      #t.integer :priority_code, index: true
      #t.integer :case_type_code, index: true

      t.string :state
      t.string :status
      t.string :priority
      t.string :case_type

      t.boolean :have_answer

      t.string :faculty
      t.references :person
      t.timestamps
    end
  end
end
