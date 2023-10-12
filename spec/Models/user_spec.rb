# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User  do
  it 'creates a user class' do
    user = User.new
    expect(user).to be_kind_of(User)
  end

  it 'is invalid without a fname' do
    user = User.new(fname: nil)

    expect(user).to_not be_valid
    # expect(user.errors[:fname]).to include("can't be blank")
  end

  it 'is invalid without a lname' do
    user = User.new(lname: nil)
    expect(user).to_not be_valid
    # expect(user.errors[:lname]).to include("can't be blank")
  end

  it 'is invalid without a email' do
    user = User.new(email: nil)
    expect(user).to_not be_valid
    # expect(user.errors[:email]).to include("can't be blank")
  end

  it 'is invalid without a password_digest' do
    user = User.new(password_digest: nil)
    expect(user).to_not be_valid
    # expect(user.errors[:password_digest]).to include("can't be blank")
  end
end
