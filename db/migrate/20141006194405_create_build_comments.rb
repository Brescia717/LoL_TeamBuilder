class CreateBuildComments < ActiveRecord::Migration
  def change
    create_table :build_comments do |t|
      t.text :body, null: false

      t.timestamps
    end
  end
end
