class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :user_id, null: false
      t.text    :about

      t.timestamps
    end
  end
end
