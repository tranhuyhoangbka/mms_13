FactoryGirl.define do
  factory :user do
    email Faker::Internet.email
    name Faker::Name.name
    birthday "1992-08-02"
    position_id {rand 1..5}
    password "123456789"
    password_confirmation "123456789"
    
    factory :admin do
      role "admin"
    end
  end
end