class AddFieldsToPerson < ActiveRecord::Migration[5.2]
  def change
    add_column :people, :career_code, :string
    add_column :people, :level, :string
    add_index :people, :level
  end
end
