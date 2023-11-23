FactoryBot.define do
  factory :appointment do
    service_id { "" }
    user_id { "" }
    fname { "John" }
    lname { "Doe" }
    email { "johndoe" }
    startdatetime { DateTime.now }
    enddatetime { startdatetime+3 }
    amount_paid { 120 }
    status { 'booked' }
  end
end
