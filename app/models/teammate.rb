class Teammate < ActiveRecord::Base
  validates :team_id, presence: true
  validates :owner_id, presence: true
  validates :member_id, presence: true

  belongs_to :user
  belongs_to :teams
  has_many   :users
end
