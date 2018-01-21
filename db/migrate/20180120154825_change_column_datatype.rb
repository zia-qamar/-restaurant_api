class ChangeColumnDatatype < ActiveRecord::Migration[5.1]
  def change
    change_column :hotels, :start_time, :time, 'timestamptz using start_time::timestamptz'
    change_column :hotels, :end_time, :time, 'timestamptz using start_time::timestamptz'
  end
end
