# frozen_string_literal: true

class Appointments < ApplicationRecord
  belongs_to :service
  enum status_type: { booked: "booked", closed: "closed", cancelled: "cancelled" }
  attribute :start_date, :date
  attribute :start_time, :datetime

  # attribute :slot_start_time, :time
  # attribute :slot_end_time, :time

  validates :fname, presence: true
  validates :lname, presence: true
  validates :email, presence: true
end
