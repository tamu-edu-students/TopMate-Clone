# frozen_string_literal: true

class Service < ApplicationRecord
  belongs_to :user
  has_many :appointments

  validates :name, presence: true
  validates :short_description, presence: true, length: { maximum: 60 }
  validates :price, presence: true
  validates :duration, presence: true
  validate :price_is_valid_precision

  def price_is_valid_precision
    return unless price.to_f != price.to_f.round(2)

    errors.add(:price, 'is invalid. Too many decimal places.')
  end
end
