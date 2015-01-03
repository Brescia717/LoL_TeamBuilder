class CreateFetchStats < ActiveRecord::Migration
  def change
    create_table :fetch_stats do |t|

      t.timestamps
    end
  end
end
