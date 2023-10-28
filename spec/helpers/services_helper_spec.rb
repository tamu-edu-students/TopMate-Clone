# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ServicesHelper, type: :helper do
  describe '#get_next_seven_day_time_slots' do
    context 'when a user exists and has availability' do
      let(:user) { User.create(fname: 'John', lname: 'Doe', email: 'test@example.com', password: 'password') }
      let(:hours) do
        [Hour.create(user_id: user.id, day: 0, start_time: '09:00', end_time: '17:00'),
         Hour.create(user_id: user.id, day: 2, start_time: '09:00', end_time: '17:00'),
         Hour.create(user_id: user.id, day: 3, start_time: '09:00', end_time: '17:00'),
         Hour.create(user_id: user.id, day: 5, start_time: '09:00', end_time: '17:00')]
      end

      it 'returns the next seven days of availability' do
        hours # loads the hours
        expect(get_next_seven_day_time_slots(user, Date.parse('01-01-2023')).length).to eq(4)
      end
    end
  end

  describe '#user_availability_for_day' do
    context 'when a user exists and has availability' do
      let(:user) { User.create(fname: 'John', lname: 'Doe', email: 'test@example.com', password: 'password') }
      let(:hour) { Hour.create(user_id: user.id, day: 0, start_time: '09:00', end_time: '17:00') }
      it 'returns users availability for a given day' do
        hour # loads the hour
        expect(user_availability_for_day(user,
                                         Date.parse('01-01-2023')).first['start_time']).to eq(hour.start_time.strftime('%T'))
      end
    end

    it 'returns nil if user is nil' do
      expect(user_availability_for_day(nil, Date.parse('01-01-2023'))).to eq(nil)
    end
  end

  describe '#get_day_of_week_int' do
    it 'returns the integer value of the day of the week' do
      expect(get_day_of_week_int(Date.parse('01-01-2023'))).to be_a Integer
    end

    days_as_ints = [
      [Date.parse('01-01-2023'), 0],
      [Date.parse('02-01-2023'), 1],
      [Date.parse('03-01-2023'), 2],
      [Date.parse('04-01-2023'), 3],
      [Date.parse('05-01-2023'), 4],
      [Date.parse('06-01-2023'), 5],
      [Date.parse('07-01-2023'), 6]
    ]
    it 'returns the correct value for all days of the week' do
      days_as_ints.each do |day, expected|
        expect(get_day_of_week_int(day)).to eq(expected)
      end
    end
  end

  describe '#remove_appts_from_hours' do
    context 'a user exists, has availability' do
      let(:user) { User.create(fname: 'John', lname: 'Doe', email: 'test@example.com', password: 'password') }
      let(:hour) { Hour.create(user_id: user.id, day: 0, start_time: '09:00', end_time: '17:00') }
      it 'splits availability when appointment is in the middle' do
        appt = Appointment.create(user_id: user.id, startdatetime: '10:00', enddatetime: '11:00')

        expect(remove_appts_from_hours([hour],
                                       [appt])).to eq([{ 'start_time' => '09:00:00', 'end_time' => '10:00:00' },
                                                       { 'start_time' => '11:00:00', 'end_time' => '17:00:00' }])
      end

      it 'removes availability when appointment is at the beginning' do
        appt = Appointment.create(user_id: user.id, startdatetime: '9:00', enddatetime: '11:00')

        expect(remove_appts_from_hours([hour],
                                       [appt])).to eq([{ 'start_time' => '11:00:00', 'end_time' => '17:00:00' }])
      end

      it 'availability does not change when appointment does not overlap' do
        appt = Appointment.create(user_id: user.id, startdatetime: '18:00', enddatetime: '19:00')

        expect(remove_appts_from_hours([hour],
                                       [appt])).to eq([{ 'start_time' => '09:00:00', 'end_time' => '17:00:00' }])
      end

      it 'removes availability when appointment overlaps hours' do
        appt = Appointment.create(user_id: user.id, startdatetime: '15:00', enddatetime: '18:00')

        expect(remove_appts_from_hours([hour],
                                       [appt])).to eq([{ 'start_time' => '09:00:00', 'end_time' => '15:00:00' }])
      end
    end
  end
end
