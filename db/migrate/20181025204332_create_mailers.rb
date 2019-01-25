class CreateMailers < ActiveRecord::Migration[5.2]
  def change
    create_table :mailers do |t|
      t.text :status
      t.references :ticket
      t.timestamps
    end
  end
end
