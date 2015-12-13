class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.integer :user_id, null: false
      t.integer :summoner_id
      t.string  :lolking_profile_url
      t.string  :tier

      t.timestamps
    end
  end
end
