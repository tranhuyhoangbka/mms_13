FactoryGirl.define do
  factory :skill do
    sequence(:name){Faker::Lorem.word}
  end
end