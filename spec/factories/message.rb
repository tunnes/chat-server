FactoryBot.define do
  factory :message do
    user
    conversation
    created_at { DateTime.now }
    content { Faker::Lorem.sentence }
  end
end