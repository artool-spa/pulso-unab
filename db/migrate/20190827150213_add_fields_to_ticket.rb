class AddFieldsToTicket < ActiveRecord::Migration[5.2]
  def change
    add_column :tickets, :impact_name, :string
    add_column :tickets, :close_first_line, :string
  end
end
