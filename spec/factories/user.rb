FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@email.com" }
    sequence(:username) { |n| "user_name#{n}" }
    summoner_name "Maokai"
    primary_role "Top"
    secondary_role "Jungle"
    password "password"
  end
end
