# frozen_string_literal: true

class Service < ApplicationRecord
  belongs_to :user
  has_many :appointment

  validates :name, presence: true, length: { maximum: 20 }
  validates :short_description, presence: true, length: { maximum: 60 }
  validates :description, length: { maximum: 10000 }
  validates :price, presence: true, numericality: { greater_than: 0, less_than: 10000 }
  validates :duration, presence: true, numericality: { greater_than: 0, less_than: 1440 }
  validate :price_is_valid_precision

  def price_is_valid_precision
    return unless price.to_f != price.to_f.round(2)

    errors.add(:price, 'is invalid. Too many decimal places.')
  end
end
