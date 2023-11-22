# frozen_string_literal: true

# spec/factories/user.rb

FactoryBot.define do
  factory :user do
    fname { 'John' }
    lname { 'Doe' }
    email { 'johndoe@example.com' }
    password_digest { BCrypt::Password.create('your_password') }
    about { 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.' }
    created_at { Time.current }
    updated_at { Time.current }
    profile_image { 'https://example.com/profile_image.jpg' }
    username { 'johndoe' }
  end
end
