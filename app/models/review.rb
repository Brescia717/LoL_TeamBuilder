class Review < ActiveRecord::Base
  validates :title, presence: true
  validates :body, presence: true
  validates :user_id, presence: true
  validates :build_id, presence: true
  validates :upvotes, presence: true
  validates :rating, presence: true, inclusion: { in: 1..10 }

  belongs_to :build
  belongs_to :user
  has_many :comments
  has_many :votes

  def owner?(user)
    self.user == user
  end

  def upvoted?(user)
    if user.nil?
      false
    else
      votes.where(user_id: user.id, score: 1).count >= 1
    end
  end

  def calculate_upvotes
    votes.sum(:score)
  end

  def self.with_score
    joins("LEFT OUTER JOIN (SELECT review_id, SUM(score) AS score FROM votes GROUP BY review_id) vote_scores ON vote_scores.review_id = reviews.id")
      .select("reviews.*, COALESCE(vote_scores.score, 0) AS score")
  end
end
