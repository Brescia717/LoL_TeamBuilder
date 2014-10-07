class CreateReviewComments < ActiveRecord::Migration
  def change
    create_table :review_comments do |t|
      t.text :body, null: false

      t.timestamps
    end
  end
end
