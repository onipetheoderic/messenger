class AddNameToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :surname, :string
    add_column :users, :last_name, :string
    add_column :users, :country, :string
    add_column :users, :state, :string
    add_column :users, :local_govt, :string

  end
end
