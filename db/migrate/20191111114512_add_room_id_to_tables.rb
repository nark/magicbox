class AddRoomIdToTables < ActiveRecord::Migration[5.2]
  def change
  	add_column :devices, :room_id, :integer
  	add_column :subjects, :room_id, :integer
  end
end
