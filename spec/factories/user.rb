FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@email.com" }
    sequence(:username) { |n| "user_name#{n}" }
    summoner_name "Maokai"
    primary_role "Top"
    secondary_role "Jungle"
    lolking_profile_link "http://www.lolking.net/summoner/na/36489078"
    password "password"
  end
end
