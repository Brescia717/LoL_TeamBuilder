class Comment < ActiveRecord::Base
  validates :body, presence: true
  validates :user_id, presence: true
  validates :build_id, presence: true

  belongs_to :build
  belongs_to :user

  def owner?(user)
    self.user == user
  end
end