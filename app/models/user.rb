# frozen_string_literal: true

class User < ApplicationRecord
  validates :fname, length: { maximum: 50 }
  validates :lname, length: { maximum: 50 }
  validates :about, length: { maximum: 10000 }
  validates :username, length: { maximum: 16 }
  validates :username, uniqueness: true, unless: -> { username.nil? || username == "" }

  has_secure_password
  has_many :hours
  has_many :services
  has_many :appointments
end
