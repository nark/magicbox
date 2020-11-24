# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#

# create default user
User.create(username: "Admin", email: "admin@example.com", password: "changeme", password_confirmation: "changeme", is_admin: true)

# create default categories
# TBD : call rake task

# create default
# TBD : call rake task

# create default room
r = Room.create(name: "Room 1", room_type: 0, length: 60, width: 60, height: 140)

# create default data types
t = DataType.create(name: "temperature")
h = DataType.create(name: "humidity")
s = DataType.create(name: "soil_moisture")
w = DataType.create(name: "water_level")

DataType.create(name: "weather_temperature")
DataType.create(name: "weather_humidity")
DataType.create(name: "weather_pressure")
DataType.create(name: "weather_clouds")
DataType.create(name: "weather_wind_speed")
DataType.create(name: "weather_wind_angle")

DataType.create(name: "cpu_usage")
DataType.create(name: "cpu_temp")
DataType.create(name: "cpu_voltage")
DataType.create(name: "memory_used")
DataType.create(name: "memory_free")

# create default device in the room
d = Device.create!(room_id: r.id, device_type: 1, device_state: 2, name: "Temp/hum", product_reference: "dht11", description: "Temperature/humidity sensor (NTC/DHT11)")
d.data_types << t
d.data_types << h

Device.create!(room_id: r.id, device_type: 2, device_state: 0, name: "Air", product_reference: "unknow", description: "Intractor/extractor device recycling the air into the room")
Device.create!(room_id: r.id, device_type: 2, device_state: 0, name: "Fan", product_reference: "unknow", description: "Fan used to move air around the room")
Device.create!(room_id: r.id, device_type: 5, device_state: 0, name: "Light", product_reference: "unknow", description: "Light giving some sun to the room")

water_category = Category.create(name: "Water", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit")
nutrients_category = Category.create(name: "Nutrients", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit")
Category.create(name: "Air", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit")
Category.create(name: "Light", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit")

Resource.create(
  name: "Water quantity",
  shortname: "H2O",
  description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
  category_id: water_category.id,
  choices: [],
  units: ["l", "dl", "cl", "ml"]
)

Resource.create(
  name: "Water type",
  shortname: "Type",
  description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
  category_id: water_category.id,
  choices: ["Tap water", "Mineral water", "Purified water", "Distiled water (reverse osmosis)"],
  units: []
)

Resource.create(
  name: "PH",
  shortname: "PH",
  description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
  category_id: water_category.id,
  choices: [],
  units: ["PH"]
)

Resource.create(
  name: "EC",
  shortname: "EC",
  description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
  category_id: water_category.id,
  choices: [],
  units: ["EC"]
)


# NUTRIENTS
Resource.create(
  name: "Nitrogen",
  shortname: "N",
  description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
  category_id: nutrients_category.id,
  choices: [],
  units: ["l", "dl", "cl", "ml"]
)

Resource.create(
  name: "Phosphorus",
  shortname: "P",
  description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
  category_id: nutrients_category.id,
  choices: [],
  units: ["l", "dl", "cl", "ml"]
)

Resource.create(
  name: "Potatium",
  shortname: "K",
  description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
  category_id: nutrients_category.id,
  choices: [],
  units: ["l", "dl", "cl", "ml"]
)

# create default scenario
s = Scenario.create!(name: "Scenario 1", enabled: true)
r.scenario = s

# create a subject in this room
su = Subject.create(room_id: r.id, name: "Subject 1")
