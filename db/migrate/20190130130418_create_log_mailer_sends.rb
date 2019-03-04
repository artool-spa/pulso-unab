class CreateLogMailerSends < ActiveRecord::Migration[5.2]
  def change
    create_table :log_mailer_sends do |t|
      t.boolean :had_answer, default: false
      t.datetime :send_date, default: nil
      t.integer :mails_count, default: 0
      t.string :crm_ticket_id
      t.references :person
      t.timestamps
    end
  end
end
