require 'os'

module DashboardHelper
	def cpu_temp
    last = Sample.where(product_reference: "System", data_type_id: DataType.find_by(name: "cpu_temp").id).order(created_at: :desc).limit(1).first
    return "#{last.value}#{last.unit}" if last
    return "0°C"
  end


  def cpu_usage
    last = Sample.where(product_reference: "System", data_type_id: DataType.find_by(name: "cpu_usage").id).order(created_at: :desc).limit(1).first
    return "#{last.value}#{last.unit}" if last
    return "0%"
  end

  def used_memory
    last = Sample.where(product_reference: "System", data_type_id: DataType.find_by(name: "memory_used").id).order(created_at: :desc).limit(1).first
    return "#{last.value}#{last.unit}" if last
    return "0 Mb"
  end

  def free_memory
    last = Sample.where(product_reference: "System", data_type_id: DataType.find_by(name: "memory_free").id).order(created_at: :desc).limit(1).first
    return "#{last.value}#{last.unit}" if last
    return "0 Mb"
  end

  def voltage
    last = Sample.where(product_reference: "System", data_type_id: DataType.find_by(name: "cpu_voltage").id).order(created_at: :desc).limit(1).first
    return "#{last.value}#{last.unit}" if last
    return "0V"
  end


  def system_info
    if OS.mac?
      "macOS"
    else
      `/usr/bin/lsb_release -d`.split(":")[1].strip
    end
  end


  def hard_info
    if OS.mac?
      "Apple"
    else
      `cat /sys/firmware/devicetree/base/model`
    end
  end


  def uptime_info
    if OS.mac?
      "Shitty"
    else
      `uptime -p`
    end
  end


  def weather_temp
    last = Sample.where(product_reference: "Openweather2", data_type_id: DataType.find_by(name: "weather_temperature").id).order(created_at: :asc).limit(1).first
    return "#{last.value}#{last.unit}" if last
    return "0°C"
  end

  def weather_humidity
    last = Sample.where(product_reference: "Openweather2", data_type_id: DataType.find_by(name: "weather_humidity").id).order(created_at: :asc).limit(1).first
    return "#{last.value}#{last.unit}" if last
    return "0%"
  end


  def kwh_cost_estimation(kWh)
    return (Magicbox::Application::KWH_COST * kWh).round(2)
  end

  def total_watts
    Room.all.inject(0) { |sum, room| sum + room.total_watts }.round(2)
  end

  def total_kwh_day
    Room.all.inject(0) { |sum, room| sum + room.kwh_day }.round(2)
  end

  def total_kwh_month
    Room.all.inject(0) { |sum, room| sum + room.kwh_month }.round(2)
  end
	
	
end