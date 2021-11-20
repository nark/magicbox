class AddRoomIdToObservations < ActiveRecord::Migration[5.2]
  def change
    add_column :observations, :room_id, :integer
  end
end
