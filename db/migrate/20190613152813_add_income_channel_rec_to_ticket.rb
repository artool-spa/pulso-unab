class AddIncomeChannelRecToTicket < ActiveRecord::Migration[5.2]
  def change
    add_column :tickets, :income_channel_rec, :string
    add_index :tickets, :income_channel_rec
  end
end
