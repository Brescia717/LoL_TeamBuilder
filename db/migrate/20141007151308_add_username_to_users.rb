class AddUsernameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_index :users, :username, unique: true
    add_column :users, :summoner_name, :string
    add_index :users, :summoner_name, unique: true
    add_column :users, :primary_role, :string
    add_index :users, :primary_role
    add_column :users, :secondary_role, :string
    add_index :users, :secondary_role
    add_column :users, :lolking_profile_link, :string
    add_index :users, :lolking_profile_link, unique: true
  end
end
