# frozen_string_literal: true

FactoryBot.define do
  factory User do
    sequence :username do |n|
      "#{n}b"
    end
    password { 'yoRHa' }
  end
end
