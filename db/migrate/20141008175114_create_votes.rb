class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer  "user_id",                null: false
      t.integer  "build_id",              null: false
      t.integer  "score",      default: 0, null: false
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
