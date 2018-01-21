class AddHotelNo < ActiveRecord::Migration[5.1]
  def change
    add_reference :guests, :hotel, foreign_key: true
    add_reference :tables, :hotel, foreign_key: true
  end
end
