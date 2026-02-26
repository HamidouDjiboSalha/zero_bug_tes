class AddPinToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :pin, :string
  end
end
