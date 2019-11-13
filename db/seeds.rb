# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#

# create default user
User.create(email: "admin@example.com", password: "changeme", password_confirmation: "changeme")

# create default room
r = Room.create(name: "Room 1", room_type: 0, length: 60, width: 60, height: 140)

# create default data types
t = DataType.create(name: "temperature")
h = DataType.create(name: "humidity")
s = DataType.create(name: "soil_moisture")
w = DataType.create(name: "water_level")

# create default device in the room
d = Device.create!(room_id: r.id, device_type: 1, device_state: 2, name: "Temperature/humidity", product_reference: "vma311", description: "Temperature/humidity (NTC/DHT11) sensor for Arduino")
d.data_types << t
d.data_types << h

d = Device.create!(room_id: r.id, device_type: 1, device_state: 2, name: "Soil moisture", product_reference: "vma303", description: "Soil moisture sensor for Arduino")
d.data_types << s

d = Device.create!(room_id: r.id, device_type: 1, device_state: 2, name: "Water level", product_reference: "vma303", description: "Water level sensor for Arduino")
d.data_types << w

Device.create!(room_id: r.id, device_type: 2, device_state: 0, name: "Cooling fan", product_reference: "SanACE40", description: "Fan used to cool the environment when the temperature goes up too much")
Device.create!(room_id: r.id, device_type: 3, device_state: 0, name: "Water pump", product_reference: "unknow", description: "Water pump used to fill the water tank when level goes down")
Device.create!(room_id: r.id, device_type: 4, device_state: 0, name: "Air pump", product_reference: "unknow", description: "Air pump to brew and keep hight level of oxygen in the water tank")

# create default scenario
s = Scenario.create!(name: "Scenario 1", enabled: true)
r.scenario = s

# create a subject in this room
su = Subject.create(room_id: r.id, name: "Subject 1")
