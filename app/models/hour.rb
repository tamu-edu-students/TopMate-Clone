# frozen_string_literal: true

class Hour < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :day, comparison: { greater_than_or_equal_to: 0, less_than: 7 }
  validates :start_time, presence: true
  validates :end_time, comparison: { greater_than: :start_time }
end
