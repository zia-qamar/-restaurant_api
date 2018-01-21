class Table < ApplicationRecord
  has_many :reservations
  validates :name, uniqueness: {scope: :hotel_id}, presence: true

  scope :from_hotel, ->(hotel_id) { where(hotel_id: hotel_id) }
end
