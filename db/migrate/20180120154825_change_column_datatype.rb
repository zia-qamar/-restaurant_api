class ChangeColumnDatatype < ActiveRecord::Migration[5.1]
  def change
    change_column :hotels, :start_time, :timestamp
    change_column :hotels, :end_time, :timestamp
  end
end
