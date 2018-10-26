class AddFieldsToToken < ActiveRecord::Migration[5.2]
  def change
    add_column :tickets, :career, :text
    add_column :tickets, :faculty, :text
    add_column :tickets, :campus, :text
    add_column :tickets, :case_type, :text
  end
end
