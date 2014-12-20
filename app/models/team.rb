class Team < ActiveRecord::Base
  acts_as_votable

  validates :user_id, presence: true
  validates :about, presence: true
  # validates :rank, presence: true
  # validates :primary_role, presence: true
  # validates :secondary_role, presence: true

  belongs_to :user
  has_many :comments
  has_many :users

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
    if Team.where(team_id: self.id).count > 0
      Team.where(team_id: id).sum(:rating) * 10 / Team.where(team_id: id).count
    else
      0
    end
  end
end
