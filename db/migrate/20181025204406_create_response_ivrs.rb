class CreateResponseIvrs < ActiveRecord::Migration[5.2]
  def change
    create_table :response_ivrs do |t|
      t.boolean :have_solution, index: true
      t.string :income_channel
      t.integer :option_1
      t.integer :option_2
      t.integer :option_3
      t.integer :option_4
      t.datetime :date_created
      t.string :crm_ticket_id
      t.references :ticket
      t.timestamps
    end

  end
end
