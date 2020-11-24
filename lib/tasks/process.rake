namespace :process do
	desc "Process all"
  task :run => :environment do
  	# Device.all.each do |d|
  	# 	if d.sensor?
  	# 		d.query_sensor
  	# 		sleep 6
  	# 	end
  	# end

  	cpu_temp = 0
  	if OS.mac?
      cpu_temp = %x[sysctl -n machdep.xcpm.cpu_thermal_level].to_f.round(1)
    else
      cpu_temp = `/usr/bin/vcgencmd measure_temp`.to_s.split("=")[1].to_f.round(1)
    end

    cpu_usage = 0 
    if OS.mac?
      cpu_usage = `ps -A -o %cpu | awk '{s+=$1} END {print s}'`
    else
      cpu_usage = `/bin/grep 'cpu ' /proc/stat | /usr/bin/awk '{usage=100-($5*100)/($2+$3+$4+$5+$6+$7+$8)} END {print usage}'`.to_f.round(1)
    end

    cpu_voltage = 0
    if OS.mac?
      cpu_voltage = `system_profiler SPPowerDataType | grep Voltage`.split(": ")[1].to_i / 1000
    else
      cpu_voltage = `/usr/bin/vcgencmd measure_volts`.split("=")[1].to_f.round(1)
    end

    used_memory = 0
    if OS.mac?
      used_memory = "0 Mi"
    else
      used_memory = `free -h | grep Mem | awk '{print $3}'`
    end

    free_memory = 0
    if OS.mac?
      free_memory = "0 Mi"
    else
      free_memory = `free -h | grep Mem | awk '{print $4}'`
    end

    Sample.create(
      product_reference: "System",
      data_type_id: DataType.find_by(name: "cpu_temp").id,
      value: cpu_temp,
      category_name: "cpu",
      html_color: "red",
      unit: "°C")

    Sample.create(
      product_reference: "System",
      data_type_id: DataType.find_by(name: "cpu_usage").id,
      value: cpu_usage,
      category_name: "cpu",
      html_color: "lightgray",
      unit: "%")

    Sample.create(
      product_reference: "System",
      data_type_id: DataType.find_by(name: "cpu_voltage").id,
      value: cpu_voltage,
      category_name: "cpu",
      html_color: "darkgray",
      unit: "V")

    Sample.create(
      product_reference: "System",
      data_type_id: DataType.find_by(name: "memory_used").id,
      value: used_memory,
      category_name: "memory",
      html_color: "lightgreen")

    Sample.create(
      product_reference: "System",
      data_type_id: DataType.find_by(name: "memory_free").id,
      value: free_memory,
      category_name: "memory",
      html_color: "lightblue")


    require "openweather2"

    Openweather2.configure do |config|
      config.endpoint = 'http://api.openweathermap.org/data/2.5/weather'
      config.apikey = "73854014820b3c26dc88ab5d14580654"
    end

    begin
      info = Openweather2.get_weather(city: 'lagrasse', units: 'metric')

      puts info.inspect

      if info 
      	Sample.create(
          product_reference: "Openweather2",
          data_type_id: DataType.find_or_create_by(name: "weather_temperature").id,
          value: info.temperature,
          category_name: "weather",
          html_color: "red",
          unit: "°C")

      	Sample.create(
          product_reference: "Openweather2",
          data_type_id: DataType.find_or_create_by(name: "weather_humidity").id,
          value: info.humidity,
          category_name: "weather",
          html_color: "lightskyblue",
          unit: "%")

        Sample.create(
          product_reference: "Openweather2",
          data_type_id: DataType.find_or_create_by(name: "weather_pressure").id,
          value: info.pressure,
          category_name: "weather",
          html_color: "yellow",
          unit: "hPa")

        Sample.create(
          product_reference: "Openweather2",
          data_type_id: DataType.find_or_create_by(name: "weather_clouds").id,
          value: info.clouds,
          category_name: "weather",
          html_color: "gray",
          unit: "%")

        Sample.create(
          product_reference: "Openweather2",
          data_type_id: DataType.find_or_create_by(name: "weather_wind_speed").id,
          value: info.wind_speed,
          category_name: "weather",
          html_color: "#98FF98",
          unit: "km/s")

        Sample.create(
          product_reference: "Openweather2",
          data_type_id: DataType.find_or_create_by(name: "weather_wind_angle").id,
          value: info.wind_angle,
          category_name: "weather",
          html_color: "#FFF380",
          unit: "°")

      end
    rescue Exception => e
      return nil
    end



  	Scenario.run

    Alert.all.each do |alert|
      alert.trigger
    end
  end
end
