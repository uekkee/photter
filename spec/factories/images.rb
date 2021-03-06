# frozen_string_literal: true

FactoryBot.define do
  factory :image do
    sequence(:url) { |n| "https://localhost.localdomain/image#{n}.jpg" }
  end
end
