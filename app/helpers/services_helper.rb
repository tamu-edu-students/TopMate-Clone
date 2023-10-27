# frozen_string_literal: true

module ServicesHelper

    $day_to_int = {
        "Sunday" => 0,
        "Monday" => 1,
        "Tuesday" => 2,
        "Wednesday" => 3,
        "Thursday" => 4,
        "Friday" => 5,
        "Saturday" => 6
    }

    def user_availability_for_day(user, date)
        day = get_day_of_week_int(date)
        if user == nil
            return nil
        end
        hours = user.hours.where(day: day)
        appts = user.appointments.where("date(startdatetime) = ?", date)
        remove_appts_from_hours(hours, appts)
    end

    def get_day_of_week_int(date)
        dow = date.strftime("%A")
        $day_to_int[dow]
    end

    def remove_appts_from_hours(hours, appts)
        final_availability = []

        hours.each do |hour|
            free_start_time = hour.start_time.strftime('%T')
            free_end_time = hour.end_time.strftime('%T')

            appts.each do |appt|
                taken_start_time = appt.startdatetime.to_time.strftime('%T')
                taken_end_time = appt.enddatetime.to_time.strftime('%T')

                if free_start_time < taken_end_time && free_end_time > taken_start_time
                    if free_start_time < taken_start_time
                        final_availability << { 'start_time' => free_start_time, 'end_time' => taken_start_time }
                    end
                    if free_end_time > taken_end_time
                        free_start_time = taken_end_time
                    else    
                        free_start_time = free_end_time
                    end
                end
            end

            if free_start_time < free_end_time
                final_availability << { 'start_time' => free_start_time, 'end_time' => free_end_time }
            end
        end
        final_availability
    end
end
