class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|
      t.string :full_name
      t.string :rut, index: true
      t.string :phone, index: true
      t.string :cellphone, index: true
      t.string :email, index: true
      t.string :academic_state, index: true
      t.string :program, index: true
      t.string :campus, index: true
      t.string :faculty, index: true
      t.boolean :send_email, index: true
      t.timestamps
    end
  end
end
