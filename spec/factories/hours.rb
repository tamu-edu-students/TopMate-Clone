FactoryBot.define do
  factory :hour do
    user_id { "" }
    day { 1 }
    start_time { "2000-01-01 12:00:00" }
    end_time { "2000-01-01 13:00:00" }
  end
end
