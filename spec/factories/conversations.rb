# frozen_string_literal: true

FactoryBot.define do
  factory :conversation do
    factory :conversation_with_users do
      transient do
        users { [create(:user), create(:user)] }
      end

      after(:create) do |conversation, evaluator|
        evaluator.users.each do |user|
          create(:user_conversation, user: user, conversation: conversation)
        end
      end
    end
  end
end
