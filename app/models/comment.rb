class Comment < ActiveRecord::Base
  validates :body, presence: true
  validates :user_id, presence: true
  validates :team_id, presence: true

  belongs_to :team
  belongs_to :user

  def owner?(user)
    self.user == user
  end
end
