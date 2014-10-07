class ReviewComment < ActiveRecord::Base
  validates :body, presence: true
  validates :review, presence: true
  validates :user, presence: true

  belongs_to :review
  belongs_to :user

  def owner?(user)
    self.user == user
  end
end
