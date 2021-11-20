class CreateDevicesDataTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :devices_data_types do |t|
      t.integer :device_id
      t.integer :data_type_id

      t.timestamps
    end

    DevicesDataType.create(device_id: 1, data_type_id: 1)
    DevicesDataType.create(device_id: 1, data_type_id: 2)
    DevicesDataType.create(device_id: 2, data_type_id: 3)
    DevicesDataType.create(device_id: 3, data_type_id: 4)
  end
end
