class Guest < ApplicationRecord
  has_many :reservations
  validates_presence_of :name, :email
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  scope :from_hotel, ->(hotel_id) { where(hotel_id: hotel_id) }
end
