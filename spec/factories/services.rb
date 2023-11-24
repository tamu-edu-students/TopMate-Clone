# frozen_string_literal: true

FactoryBot.define do
  factory :service do
    association :user
    name { 'Test Service' }
    description { 'Test service description' }
    price { 120 }
    duration { 10 }
    is_published { false }
    hidden { false }
    short_description { 'Test short description' }
  end
end
