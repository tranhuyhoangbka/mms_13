FactoryGirl.define do
  factory :skill do
    sequence(:name){|n| "#{Faker::Lorem.word}#{n}"}
  end
end