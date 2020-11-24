namespace :data_types do
	desc "New data_types"
  task :new => :environment do
  	DataType.find_or_create_by(name: "cpu_usage")
		DataType.find_or_create_by(name: "cpu_temp")
		DataType.find_or_create_by(name: "cpu_voltage")
		DataType.find_or_create_by(name: "memory_used")
		DataType.find_or_create_by(name: "memory_free")
  end

  task :weather => :environment do
  	DataType.find_or_create_by(name: "weather_temperature")
		DataType.find_or_create_by(name: "weather_humidity")
		DataType.find_or_create_by(name: "weather_pressure")
		DataType.find_or_create_by(name: "weather_clouds")
		DataType.find_or_create_by(name: "weather_wind_speed")
		DataType.find_or_create_by(name: "weather_wind_angle")
  end
end
		