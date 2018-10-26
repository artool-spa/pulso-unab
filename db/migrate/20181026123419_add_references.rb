class AddReferences < ActiveRecord::Migration[5.2]
  def change
    add_reference :answers, :ticket
    add_reference :mailers, :ticket
    add_reference :tickets, :person
  end
end
