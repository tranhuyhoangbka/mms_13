FactoryGirl.define do
  factory :user do
    association :position
    association :team
    
    sequence(:email){|n| "example#{n}@gmail.com"}
    sequence(:name){Faker::Name.name}
    birthday "1992-08-02"
    position_id {rand 1..5}
    password "123456789"
    password_confirmation "123456789"
    
    factory :admin do
      role "admin"
    end

    factory :invalid_user do
      name nil
    end
  end
end