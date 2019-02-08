class CreateLogMailerSends < ActiveRecord::Migration[5.2]
  def change
    create_table :log_mailer_sends do |t|
      t.boolean :had_answer
      t.datetime :send_date
      t.integer :mails_count
      t.string :ticket_id
      t.references :person
      t.timestamps
    end
  end
end
