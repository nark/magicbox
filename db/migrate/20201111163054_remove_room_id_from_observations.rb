class RemoveRoomIdFromObservations < ActiveRecord::Migration[5.2]
  def change
  	remove_column :observations, :room_id
  end
end
