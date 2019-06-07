class CreateCareers < ActiveRecord::Migration[5.2]
  def change
    create_table :careers do |t|
      t.string :program_id
      t.string :name
      t.string :level
      t.string :time
      t.string :type

      t.timestamps
    end
  end
end
