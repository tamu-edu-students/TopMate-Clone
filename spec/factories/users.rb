# spec/factories/user.rb

FactoryBot.define do
    factory :user do
      fname { 'John' }
      lname { 'Doe' }
      email { 'johndoe@example.com' }
      password { 'your_password' } 
      # Other user attributes...
    end
  end
  