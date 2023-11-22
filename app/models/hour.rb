# frozen_string_literal: true

class Hour < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :day, comparison: { greater_than_or_equal_to: 0, less_than: 7 }
  validates :start_time, presence: true
  validates :end_time, comparison: { greater_than: :start_time , message: "must be greater than the start time"  }
  validate :times_must_be_fifteen_min_intervals
  validate :must_have_30_min_gap
  validate :times_must_not_overlap

  def times_must_be_fifteen_min_intervals
    errors.add(:start_time, 'start time must be on 15-minute interval') if start_time.nil? || start_time.min % 15 != 0
    return unless end_time.nil? || end_time.min % 15 != 0

    errors.add(:end_time, 'start time must be on 15-minute interval')
  end

  def must_have_30_min_gap
    return if start_time.nil? || end_time.nil?

    start_stamp = start_time.hour * 60 + start_time.min
    end_stamp = end_time.hour * 60 + end_time.min
    return unless end_stamp - start_stamp < 30

    errors.add(:end_time, 'must at least 30 minutes after start time')
  end

  def times_must_not_overlap
    return if start_time.nil? || end_time.nil?

    all_user_hours = Hour.where(user_id:)
    all_user_hours.each do |h|
      # ignore if different day
      next if day != h.day

      # calculate minutes since midnight
      start_stamp = start_time.hour * 60 + start_time.min
      end_stamp = end_time.hour * 60 + end_time.min
      h_start_stamp = h.start_time.hour * 60 + h.start_time.min
      h_end_stamp = h.end_time.hour * 60 + h.end_time.min
      # check position
      if start_stamp >= h_start_stamp && start_stamp <= h_end_stamp
        errors.add(:start_time, 'cannot overlap with another availability')
      end
      if end_stamp >= h_start_stamp && end_stamp <= h_end_stamp
        errors.add(:end_time, 'cannot overlap with another availability')
      end
      if start_stamp < h_start_stamp && end_stamp > h_end_stamp
        errors.add(:start_time, 'cannot overlap with another availability')
        errors.add(:end_time, 'cannot overlap with another availability')
      end
    end
  end
end
