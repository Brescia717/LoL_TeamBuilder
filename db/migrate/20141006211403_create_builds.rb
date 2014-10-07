class CreateBuilds < ActiveRecord::Migration
  def change
    create_table :builds do |t|
      t.string :title, null: false
      t.string :champion, null: false
      t.text :about, null: false
      t.text :tips

      t.timestamps
    end
  end
end
