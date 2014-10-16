class CreateMasteries < ActiveRecord::Migration
  def change
    create_table :masteries do |t|
      t.integer :uid, null: false
      t.string :name, null: false
      t.string :image_name, null: false
      t.text :description, null: false, array: true

      t.timestamps
    end
  end
end
