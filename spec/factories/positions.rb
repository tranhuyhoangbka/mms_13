FactoryGirl.define do
  factory :position do
    sequence(:name){Faker::Name.name}
    sequence(:abbreviation){Faker::Lorem.word}
  end
end