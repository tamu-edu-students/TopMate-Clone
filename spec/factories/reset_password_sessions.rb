# frozen_string_literal: true

# spec/factories/reset_password_sessions.rb

FactoryBot.define do
  factory :reset_password_session do
    user { association(:user) }
    session_token { SecureRandom.uuid }
  end
end
