class CreateTeammates < ActiveRecord::Migration
  def change
    create_table :teammates do |t|

      t.timestamps
    end
  end
end
