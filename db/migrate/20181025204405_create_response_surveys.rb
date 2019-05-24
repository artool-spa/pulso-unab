class CreateResponseSurveys < ActiveRecord::Migration[5.2]
  def change
    create_table :response_surveys do |t|
      t.bigint :api_id, index: true
      t.string :answer_type, index: true
      #t.boolean :have_solution
      #t.integer :level_effort
      #t.string :descript_effort
      #t.integer :level_executive
      #t.integer :level_time_respond
      t.string :income_channel
      t.text :question
      t.text :answer
      t.string :satisfaction
      t.bigint :sm_response_id, index: true
      t.bigint :sm_question_id, index: true
      t.string :crm_ticket_id
      t.datetime :date_created
      t.datetime :date_updated
      t.references :ticket
      t.timestamps
    end

  end
end
