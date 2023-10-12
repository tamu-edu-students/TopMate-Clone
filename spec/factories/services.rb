FactoryBot.define do
  factory :service do
    name { "MyString" }
    information { "MyText" }
    duration { 1 }
    user { nil }
  end
end
