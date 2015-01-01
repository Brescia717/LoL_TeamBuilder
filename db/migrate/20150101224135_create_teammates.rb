class CreateTeammates < ActiveRecord::Migration
  def change
    create_table :teammates do |t|
      t.integer :team_id, null: false
      t.integer :owner_id, null: false
      t.integer :member_id,  null: false

      t.timestamps
    end
  end
end
