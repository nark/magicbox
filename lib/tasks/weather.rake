require 'dotenv/load'

namespace :weather do
	desc "Get weather info"
  task :get => :environment do
    require "openweather2"

    Openweather2.configure do |config|
      config.endpoint = Setting.openweather_endpoint
      config.apikey   = ENV['OPENWEATHER2_API_KEY']
    end

    begin
      info = Openweather2.get_weather(city: Setting.openweather_city, units: 'metric')

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
  end
end
