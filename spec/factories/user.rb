FactoryBot.define do
  factory :user do
    full_name { Faker::Name.name }
    password { Faker::Internet.password }
    user_name { Faker::Internet.username }
  end
end