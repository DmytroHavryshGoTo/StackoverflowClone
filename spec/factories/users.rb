FactoryBot.define do
  sequence :email do |n|
    "user#{n}@gmail.com"
  end

  factory :user do
    email
    password { '123456' }
    password_confirmation { '123456' }
    created_at { Time.now }
  end
end
