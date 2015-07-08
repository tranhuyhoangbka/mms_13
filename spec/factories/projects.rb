FactoryGirl.define do
  factory :project do
    name Faker::Name.name
    abbreviation Faker::Name.first_name
    start_date "2015-01-01"
    end_date "2016-01-01"

    factory :invalid_project do
      name nil
    end
  end
end
