# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item do
    uid 1
    name "MyString"
    image_name "MyString"
    description "MyText"
  end
end
