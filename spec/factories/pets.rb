# frozen_string_literal: true

FactoryBot.define do
  factory :pet do
    name { Faker::Creature::Animal.unique.name }
    tag { Faker::Mountain.name }
  end
end
