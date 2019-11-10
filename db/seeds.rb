# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#

User.create(email: "admin@example.com", password: "changeme", password_confirmation: "changeme")

DataType.create(name: "temperature")
DataType.create(name: "humidity")
DataType.create(name: "soil_moisture")
DataType.create(name: "water_level")

Device.create(device_type: 1, device_state: 2, name: "Temperature/humidity", product_reference: "vma311", description: "Temperature/humidity (NTC/DHT11) sensor for Arduino")
Device.create(device_type: 1, device_state: 2, name: "Soil moisture", product_reference: "vma303", description: "Soil moisture sensor for Arduino")
Device.create(device_type: 1, device_state: 2, name: "Water level", product_reference: "vma303", description: "Water level sensor for Arduino")
Device.create(device_type: 2, device_state: 0, name: "Cooling fan", product_reference: "SanACE40", description: "Fan used to cool the environment when the temperature goes up too much")
Device.create(device_type: 3, device_state: 0, name: "Water pump", product_reference: "unknow", description: "Water pump used to fill the water tank when level goes down")
Device.create(device_type: 4, device_state: 0, name: "Air pump", product_reference: "unknow", description: "Air pump to brew and keep hight level of oxygen in the water tank")