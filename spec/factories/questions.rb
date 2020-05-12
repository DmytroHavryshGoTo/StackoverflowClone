FactoryBot.define do
  sequence :title do |n|
    "MyString#{n}"
  end

  factory :question do
    title
    body { "MyString" }
    user
  end
end
