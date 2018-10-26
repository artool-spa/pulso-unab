class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.boolean :have_solution
      t.decimal :level_effort
      t.text :descript_effort
      t.decimal :level_executive
      t.decimal :level_time_respond
      t.string :income_channel
      t.timestamps
    end
  end
end
