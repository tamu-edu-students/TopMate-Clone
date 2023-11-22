# frozen_string_literal: true

class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :service
  enum status_type: { booked: 'booked', closed: 'closed', cancelled: 'cancelled' }
  attribute :start_date, :date
  attribute :start_time, :datetime
  validates :fname, presence: true, allow_nil: false
  validates :lname, presence: true, allow_nil: false
  validates :email, presence: true, allow_nil: false
end
