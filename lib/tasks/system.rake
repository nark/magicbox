require 'os'

namespace :system do
	desc "Get system info"
  task :info => :environment do
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

  end
end