# frozen_string_literal: true

module AppointmentsHelper
  $day_to_int = {
    'Sunday' => 0,
    'Monday' => 1,
    'Tuesday' => 2,
    'Wednesday' => 3,
    'Thursday' => 4,
    'Friday' => 5,
    'Saturday' => 6
  }

  def get_next_seven_day_time_slots(user, date)
    current_day = date
    next_seven_day_time_slots = []
    7.times do
      times = user_availability_for_day(user, current_day)
      times.each do |time|
        next_seven_day_time_slots << {
          'start_date_time' => current_day.to_time + Time.parse(time['start_time']).seconds_since_midnight.seconds,
          'end_date_time' => current_day.to_time + Time.parse(time['end_time']).seconds_since_midnight.seconds
        }
      end
      current_day += 1
    end
    next_seven_day_time_slots
  end

  def user_availability_for_day(user, date)
    day = get_day_of_week_int(date)
    return nil if user.nil?

    hours = user.hours.where(day:)
    appts = user.appointments.where('date(startdatetime) = ? AND status = \'Booked\'', date)
    remove_appts_from_hours(hours, appts)
  end

  def get_day_of_week_int(date)
    dow = date.strftime('%A')
    $day_to_int[dow]
  end

  def remove_appts_from_hours(hours, appts)
    final_availability = []

    hours.each do |hour|
      free_start_time = hour.start_time.strftime('%T')
      free_end_time = hour.end_time.strftime('%T')

      appts.sort_by { |appt| appt[:startdatetime] }.each do |appt|
        taken_start_time = appt.startdatetime.to_time.strftime('%T')
        taken_end_time = appt.enddatetime.to_time.strftime('%T')

        next unless free_start_time < taken_end_time && free_end_time > taken_start_time

        if free_start_time < taken_start_time
          final_availability << { 'start_time' => free_start_time, 'end_time' => taken_start_time }
        end
        free_start_time = if free_end_time > taken_end_time
                            taken_end_time
                          else
                            free_end_time
                          end
      end

      if free_start_time < free_end_time
        final_availability << { 'start_time' => free_start_time, 'end_time' => free_end_time }
      end
    end
    final_availability
  end
end
