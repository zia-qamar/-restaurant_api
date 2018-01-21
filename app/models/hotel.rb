class Hotel < ApplicationRecord

  has_many :reservations
  validates_presence_of :email, :phone, :name
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates :phone, :numericality => true, :length => { :minimum => 6, :maximum => 15 }
  validate :end_after_start

  private
  def end_after_start
    return if self.end_time.blank? || self.start_time.blank?

    if self.end_time < self.start_time
      errors.add(:end_time, "must be after the start time")
    end
  end
end
