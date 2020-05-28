FactoryBot.define do
  sequence :email do |n|
    "user#{n}@gmail.com"
  end

  factory :user do
    email
    password { '123456' }
    password_confirmation { '123456' }
    first_name { 'John' }
    last_name { 'Dou' }
    admin { false }
    created_at { Time.now }
    confirmed_at { Time.now }
  end
end
