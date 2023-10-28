# frozen_string_literal: true

class Service < ApplicationRecord
  belongs_to :user
  has_many :appointment
end
