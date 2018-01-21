class Reservation < ApplicationRecord
  belongs_to :hotel
  belongs_to :guest
  belongs_to :table

  validates :res_time, uniqueness: {scope: [:hotel_id, :guest_id, :table_id]}, presence: true
  scope :from_hotel, ->(hotel_id) { where(hotel_id: hotel_id) }
end
