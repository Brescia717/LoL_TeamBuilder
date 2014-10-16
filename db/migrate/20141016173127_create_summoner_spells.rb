class CreateSummonerSpells < ActiveRecord::Migration
  def change
    create_table :summoner_spells do |t|
      t.integer :uid, null: false
      t.string :name, null: false
      t.text :description, null: false
      t.string :image_name, null: false

      t.timestamps
    end
  end
end
