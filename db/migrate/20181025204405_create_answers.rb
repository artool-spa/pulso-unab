class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.boolean :have_solution
      t.integer :level_effort
      t.string :descript_effort
      t.integer :level_executive
      t.integer :level_time_respond
      t.string :income_channel
      t.references :ticket
      t.timestamps
    end
  end
end
