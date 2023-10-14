# frozen_string_literal: true

FactoryBot.define do
  factory :service do
    name { 'MyString' }
    information { 'MyText' }
    duration { 1 }
    user { nil }
  end
end
