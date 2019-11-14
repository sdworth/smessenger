# frozen_string_literal: true

FactoryBot.define do
  factory :message do
    conversation
    user
    sequence :body do |n|
      "#{n}. Maybe if I keep believing, my dreams will come to life..."
    end
  end
end
