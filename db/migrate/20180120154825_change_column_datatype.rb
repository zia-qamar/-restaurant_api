class ChangeColumnDatatype < ActiveRecord::Migration[5.1]
  def change
    change_column :hotels, :start_time, :time
    change_column :hotels, :end_time, :time
  end
end
