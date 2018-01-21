class RenameShift < ActiveRecord::Migration[5.1]
  def change
    rename_column :hotels, :morning_shift, :start_time
    rename_column :hotels, :evening_shift, :end_time
  end
end
