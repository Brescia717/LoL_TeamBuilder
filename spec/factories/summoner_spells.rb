# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :summoner_spell do
    uid 1
    name "MyString"
    description "MyText"
    image_name "MyString"
  end
end
