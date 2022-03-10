class AddFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :username, :string
    add_column :users, :contact, :string
    add_column :users, :address, :string
    add_column :users, :role, :integer, default: 1
  end
end
