# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    username { Faker::Internet.unique.username }
    password { Faker::Internet.password }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.unique.email }
    phone { Faker::Number.unique.leading_zero_number }
  end
end
