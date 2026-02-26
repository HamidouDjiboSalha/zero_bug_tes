class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.string :reference
      t.decimal :amount
      t.string :status
      t.string :sender
      t.string :receiver

      t.timestamps
    end
  end
end
