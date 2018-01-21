class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.datetime :res_time
      t.references :hotel, foreign_key: true
      t.references :guest, foreign_key: true

      t.timestamps
    end
  end
end
