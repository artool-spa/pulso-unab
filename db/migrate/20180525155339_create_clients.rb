class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :name
      t.bigint :fb_ad_account_id
      t.string :ga_ad_account_id
      t.integer :fb_dollar_conv, null: false, default: 1
      t.integer :ga_dollar_conv, null: false, default: 1
      t.string :main_color
      t.boolean :is_enabled, default: true
      t.timestamp :last_update

      t.timestamps
    end
  end
end
