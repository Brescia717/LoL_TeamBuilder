class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.integer :user_id, null: false
      t.integer :summoner_id, null: false
      t.string  :lolking_profile_url, null: false
      t.string  :tier, null: false

      t.timestamps
    end
  end
end
