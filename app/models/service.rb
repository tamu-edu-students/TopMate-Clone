# frozen_string_literal: true

class Service < ApplicationRecord
  belongs_to :user
  has_many :appointment

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :duration, presence: true
  validate :price_is_valid_precision

  def price_is_valid_precision
    if price.to_f != price.to_f.round(2)
      errors.add(:price, "is invalid. Too many decimal places.")
    end
  end
end
