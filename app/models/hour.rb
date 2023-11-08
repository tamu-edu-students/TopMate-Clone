# frozen_string_literal: true

class Hour < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :day, comparison: { greater_than_or_equal_to: 0, less_than: 7 }
  validates :start_time, presence: true
  validates :end_time, comparison: { greater_than: :start_time }
  validate :times_must_be_fifteen_min_intervals

  def times_must_be_fifteen_min_intervals
    if start_time.min % 15 != 0
      errors.add(:start_time, "start time must be on 15-minute interval")
    end
    if end_time.min % 15 != 0
      errors.add(:end_time, "start time must be on 15-minute interval")
    end
  end
end
