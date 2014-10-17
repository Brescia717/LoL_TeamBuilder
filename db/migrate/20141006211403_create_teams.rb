class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :user_id, null: false
      t.text    :about
      t.string  :rank, null: false
      t.string  :primary_role, null: false
      t.string  :secondary_role, null: false

      t.timestamps
    end
  end
end
