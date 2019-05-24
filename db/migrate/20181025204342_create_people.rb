class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|
      #t.integer :person_id, index: true
      t.string :contact_id, index:true
      t.string :full_name
      t.string :rut, index: true
      t.string :phone, index: true
      t.string :cellphone, index: true
      t.string :email, index: true
      t.string :career, index: true
      t.string :campus, index: true
      t.string :faculty, index: true
      t.string :regimen, index: true
      t.integer :mail_send_counts, default: 0 
      t.datetime :mail_send_date, default: nil
      t.timestamps
    end
  end
end
