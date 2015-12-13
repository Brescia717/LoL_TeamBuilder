class Stat < ActiveRecord::Base
  # validates_presence_of :summoner_id
  # validates_presence_of :lolking_profile_url
  # validates_presence_of :tier

  belongs_to :user
end
