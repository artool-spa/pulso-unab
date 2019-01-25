class CreateMapFields < ActiveRecord::Migration[5.2]
  def change
    create_table :map_fields do |t|
      t.string :asking_key
      t.integer :key
    end
  end
end
