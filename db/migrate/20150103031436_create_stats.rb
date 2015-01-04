class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.integer :user_id, null: false, unique: true
      t.integer :summoner_id, null: false, unique: true
      t.string  :lolking_profile_url, null: false, unique: true
      t.string  :tier, null: false

      t.timestamps
    end
  end
end
