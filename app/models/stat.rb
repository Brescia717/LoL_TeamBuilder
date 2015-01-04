class Stat < ActiveRecord::Base
  # validates :summoner_id
  # validates :lolking_profile_url
  # validates :tier

  belongs_to :user
end
