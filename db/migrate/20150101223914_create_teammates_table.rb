class CreateTeammatesTable < ActiveRecord::Migration
  def change
    create_table :teammates_tables do |t|
      t.integer :team_id, null: false
      t.integer :user_id, null: false
      t.string  :member,  null: false
    end
  end
end
