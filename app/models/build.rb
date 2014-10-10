class Build < ActiveRecord::Base
  acts_as_votable

  validates :title, presence: true
  validates :champion, presence: true
  validates :about, presence: true
  validates :tips, presence: true
  validates :user_id, presence: true

  belongs_to :user
  # has_many :scores
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

  # def calculate_upvotes
  #   votes.sum(:score)
  # end

  def self.with_score
    joins("LEFT OUTER JOIN (SELECT build_id, SUM(score) AS score FROM votes GROUP BY build_id) vote_scores ON vote_scores.build_id = builds.id")
      .select("builds.*, COALESCE(vote_scores.score, 0) AS score")
  end

  # def self.search(search)
  #   if search.present?
  #     where("name ilike :q or city ilike :q or state ilike :q", q: "%#{search}%")
  #   else
  #     self.all # Needs to be fixed when pagination is done
  #   end
  # end

  def calculate_rating
    if Build.where(build_id: self.id).count > 0
      Build.where(build_id: id).sum(:rating) * 10 / Build.where(build_id: id).count
    else
      0
    end
  end
end
