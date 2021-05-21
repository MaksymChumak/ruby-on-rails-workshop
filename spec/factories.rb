# frozen_string_literal: true

require "faker"

FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    author { Faker::Book.author }
    price { Faker::Number.digit }

    trait :with_review do
      association :review
    end
  end

  factory :review do
    text { Faker::Books::Lovecraft.sentence }
    score { Faker::Number.between(from: 0, to: 100) }
    reviewed_by { Faker::Name.name }
  end
end