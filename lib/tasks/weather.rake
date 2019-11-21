namespace :weather do
	desc "Get weather info"
  task :get => :environment do
    require "openweather2"

    Openweather2.configure do |config|
      config.endpoint = 'http://api.openweathermap.org/data/2.5/weather'
      config.apikey = "73854014820b3c26dc88ab5d14580654"
    end

    begin
      info = Openweather2.get_weather(city: 'paris', units: 'metric')

      puts info.inspect

      if info 
      	Sample.create(
          product_reference: "Openweather2",
          data_type_id: 1,
          value: info.temperature,
          category_name: "weather",
          html_color: "red",
          unit: "°C")

      	Sample.create(
          product_reference: "Openweather2",
          data_type_id: 2,
          value: info.humidity,
          category_name: "weather",
          html_color: "lightskyblue",
          unit: "%")
      end
    rescue Exception => e
      return nil
    end
  end
end
