class CreateDevices < ActiveRecord::Migration[5.2]
  def change
    create_table :devices do |t|
      t.integer :device_type
      t.integer :device_state
      t.string :name
      t.string :product_reference
      t.text :description

      t.timestamps
    end

    Device.create(device_type: 1, device_state: 2, name: "Temperature/humidity", product_reference: "vma311", description: "Temperature/humidity (NTC/DHT11) sensor for Arduino")
    Device.create(device_type: 1, device_state: 2, name: "Soil moisture", product_reference: "vma303", description: "Soil moisture sensor for Arduino")
    Device.create(device_type: 1, device_state: 2, name: "Water level", product_reference: "vma303", description: "Water level sensor for Arduino")
    Device.create(device_type: 2, device_state: 0, name: "Cooling fan", product_reference: "SanACE40", description: "Fan used to cool the environment when the temperature goes up too much")
    Device.create(device_type: 3, device_state: 0, name: "Water pump", product_reference: "unknow", description: "Water pump used to fill the water tank when level goes down")
    Device.create(device_type: 4, device_state: 0, name: "Air pump", product_reference: "unknow", description: "Air pump to brew and keep hight level of oxygen in the water tank")
  end
end
