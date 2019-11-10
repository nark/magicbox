class UpdateCrons2 < ActiveRecord::Migration[5.2]
  def change
  	change_column :crons, :time, :time
  	rename_column :crons, :time, :start_time
  	add_column :crons, :end_time, :time
  end
end
