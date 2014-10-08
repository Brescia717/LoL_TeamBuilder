class AddColumnToBuildComments < ActiveRecord::Migration
  def change
    add_column :build_comments, :user_id, :integer
    add_column :build_comments, :build_id, :integer
  end
end
