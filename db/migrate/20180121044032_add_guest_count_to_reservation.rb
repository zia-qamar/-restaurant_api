class AddGuestCountToReservation < ActiveRecord::Migration[5.1]
  def change
    add_column :reservations, :guest_count, :integer
    add_reference :reservations, :table, foreign_key: true
  end
end
