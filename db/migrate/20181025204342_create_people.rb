class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|
      t.text :first_name
      t.text :last_name
      t.text :rut
      t.text :email
      t.timestamps
    end
  end
end
