class ChangeColumnDatatype < ActiveRecord::Migration[5.1]
  def change
    change_column :hotels, :start_time, 'timestamptz using start_time::timestamptz'
    change_column :hotels, :end_time, 'timestamptz using end_time::timestamptz'
  end
end
