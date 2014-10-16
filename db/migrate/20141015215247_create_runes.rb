class CreateRunes < ActiveRecord::Migration
  def change
    create_table :runes do |t|
      t.integer :uid, null: false
      t.string :name, null: false
      t.string :image_name, null: false
      t.text :description, null: false

      t.timestamps
    end
  end
end
