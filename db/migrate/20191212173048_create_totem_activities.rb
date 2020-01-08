class CreateTotemActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :totem_activities do |t|
      t.string     :crm_totem_activity_id, index: true
      t.string     :name
      t.datetime   :attention_time_start
      t.datetime   :attetion_time_end
      t.string     :rut
      t.string     :executive_name
      t.datetime   :broadcast_time
      t.string     :description
      t.string     :row_letter
      t.string     :branch_office
      t.string     :attention_number
      t.string     :state, index: true
      t.string     :status, index: true
      t.references :person
      t.timestamps
    end
  end
end
