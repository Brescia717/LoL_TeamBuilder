class Teammate < ActiveRecord::Base
  validates :team_id, presence: true
  validates :user_id, presence: true
  validates :member

  belongs_to :teams
  has_many   :users
end
