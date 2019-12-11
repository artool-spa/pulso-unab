class AddSubjectidToTicket < ActiveRecord::Migration[5.2]
  def change
    add_column :tickets, :crm_classification, :string
  end
end
