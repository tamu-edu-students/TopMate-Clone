# frozen_string_literal: true

# spec/models/hour_spec.rb

require 'rails_helper'

RSpec.describe Hour, type: :model do

  it 'is valid with valid attributes' do
    user = create(:user)
    hour = Hour.new(
      user: user,
      day: 1,
      start_time: '09:00',
      end_time: '17:00'
    )
    expect(hour).to be_valid
  end

  it 'is not valid without a user' do
    hour = Hour.new(
      day: 1,
      start_time: '09:00',
      end_time: '17:00'
    )
    expect(hour).not_to be_valid
  end

  it 'is not valid with an invalid day' do
    user = create(:user)
    hour = Hour.new(
      user: user,
      day: 7, # An invalid day value
      start_time: '09:00',
      end_time: '17:00'
    )
    expect(hour).not_to be_valid
  end

  it 'is not valid without a start_time' do
    user = create(:user)
    hour = Hour.new(
      user: user,
      day: 1,
      end_time: '17:00'
    )
    expect(hour).not_to be_valid
  end

  it 'is not valid with an end_time earlier than start_time' do
    user = create(:user)
    hour = Hour.new(
      user: user,
      day: 1,
      start_time: '17:00',
      end_time: '09:00' # End time earlier than start time
    )
    expect(hour).not_to be_valid
  end


  let(:user) { User.create }

  describe 'validations' do
    it 'validates presence of user_id' do
      hour = Hour.new
      hour.valid?
      expect(hour.errors[:user_id]).to include("can't be blank")
    end

    it 'validates day' do
      hour = Hour.new(day: 10)
      hour.valid?
      expect(hour.errors[:day]).to include('must be less than 7')
    end

    it 'validates presence of start_time' do
      hour = Hour.new
      hour.valid?
      expect(hour.errors[:start_time]).to include("can't be blank")
    end

    it 'validates end_time' do
      hour = Hour.new(start_time: Time.new(2023, 1, 1, 12, 15), end_time: Time.new(2023, 1, 1, 12, 00))
      hour.valid?
      expect(hour.errors[:end_time]).to include('must be greater than the start time')
    end

    it 'validates times must be fifteen minute intervals' do
      hour = Hour.new(start_time: Time.new(2023, 1, 1, 12, 10))
      hour.valid?
      expect(hour.errors[:start_time]).to include('start time must be on 15-minute interval')

      hour = Hour.new(start_time: Time.new(2023, 1, 1, 12, 0), end_time: Time.new(2023, 1, 1, 12, 14))
      hour.valid?
      expect(hour.errors[:end_time]).to include('start time must be on 15-minute interval')
    end

    it 'validates must have 30 minute gap' do
      hour = Hour.new(start_time: Time.new(2023, 1, 1, 12, 0), end_time: Time.new(2023, 1, 1, 12, 29))
      hour.valid?
      expect(hour.errors[:end_time]).to include('must at least 30 minutes after start time')
    end

    describe '#times_must_not_overlap' do
    let(:user) { create(:user) } # Assuming you have a User model

    it 'does not add errors for non-overlapping availability' do
      start_time = Time.now
      end_time = start_time + 1.hour

      hour = Hour.new(start_time: start_time, end_time: end_time, user: user)
      hour.times_must_not_overlap

      expect(hour.errors).to be_empty
    end

    it 'adds errors for overlapping availability' do
      existing_hour = create(:hour, user: user) # Assuming you have a factory for the Hour model

      hour = Hour.new(
        start_time: existing_hour.start_time + 30.minutes,
        end_time: existing_hour.end_time - 30.minutes,
        day: existing_hour.day,
        user: user
      )
      hour.times_must_not_overlap

      expect(hour.errors[:start_time]).to include('cannot overlap with another availability')
      expect(hour.errors[:end_time]).to include('cannot overlap with another availability')
    end

    it 'adds errors for overlapping availability' do
      existing_hour = create(:hour, user: user) # Assuming you have a factory for the Hour model

      hour = Hour.new(
        start_time: existing_hour.start_time - 30.minutes,
        end_time: existing_hour.end_time + 30.minutes,
        day: existing_hour.day,
        user: user
      )
      hour.times_must_not_overlap

      expect(hour.errors[:start_time]).to include('cannot overlap with another availability')
      expect(hour.errors[:end_time]).to include('cannot overlap with another availability')
    end

    # Add more test cases for other scenarios as needed

  end
  end
end
