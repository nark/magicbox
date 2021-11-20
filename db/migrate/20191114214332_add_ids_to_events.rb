class AddIdsToEvents < ActiveRecord::Migration[5.2]
  def change
  	add_column :events, :room_id, :integer
  	add_column :events, :device_id, :integer
  end
end
