class DeviceToDeviceTypeInOperations < ActiveRecord::Migration[5.2]
  def change
  	add_column :operations, :device_type, :integer, default: 0

  	Operation.all.each do |operation|
  		operation.device_type = operation.device.device_type
  		operation.save!
  	end

  	remove_column :operations, :device_id
  end
end
