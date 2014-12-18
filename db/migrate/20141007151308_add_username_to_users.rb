class AddUsernameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_index :users, :username, unique: true
    add_column :users, :summoner_name, :string
    add_column :users, :primary_role, :string
    add_column :users, :secondary_role, :string
  end
end
