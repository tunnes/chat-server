FactoryBot.define do
  factory :conversation do
    access_type { 0 }
    title { nil }
    users { FactoryGirl.create_list(:user, 2) }

    trait :with_messages do
      after(:create) do |conversation|
        create_list(:message, 2, conversation: conversation)
      end
    end
  end
end