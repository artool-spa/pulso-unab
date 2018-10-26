class CreateTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :tickets do |t|
      t.decimal :case_number
      t.boolean :have_answer
      t.text :owner
      t.text :author      
      t.timestamps
    end
  end
end
