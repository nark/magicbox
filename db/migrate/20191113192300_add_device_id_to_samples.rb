class AddDeviceIdToSamples < ActiveRecord::Migration[5.2]
  def change
  	add_column :samples, :device_id, :integer
  end
end
