class CreateDeposits < ActiveRecord::Migration[7.1]
  def change
    create_table :deposits do |t|
      t.string :client_phone
      t.integer :amount
      t.string :reference
      t.string :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
