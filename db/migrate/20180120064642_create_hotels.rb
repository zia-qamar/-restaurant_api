class CreateHotels < ActiveRecord::Migration[5.1]
  def change
    create_table :hotels do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :morning_shift
      t.string :evening_shift

      t.timestamps
    end
  end
end
