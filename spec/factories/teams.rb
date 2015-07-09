FactoryGirl.define do
  factory :team do
    sequence(:name){Faker::Name.name}
    sequence(:description){Faker::Lorem.paragraph}
  end
end