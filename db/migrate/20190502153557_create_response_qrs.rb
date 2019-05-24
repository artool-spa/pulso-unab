class CreateResponseQrs < ActiveRecord::Migration[5.2]
  def change
    create_table :response_qrs do |t|
      t.string :qr_code, index: true
      t.bigint :api_id, index: true
      t.string :answer_type, index: true
      t.text :question
      t.text :answer
      t.string :satisfaction
      t.bigint :sm_response_id, index: true
      t.bigint :sm_question_id, index: true
      t.datetime :date_created
      t.datetime :date_updated
      t.timestamps
    end
  end
end
