FactoryBot.define do
  factory :appointment do
    service_id { "" }
    user_id { "" }
    fname { "John" }
    lname { "Doe" }
    email { "johndoe" }
    startdatetime { DateTime.parse(DateTime.now.strftime('%Y-%m-%d %H:%M')) }
    enddatetime { startdatetime + 10.minutes }
    amount_paid { 120 }
    status { 'booked' }
  end
end
