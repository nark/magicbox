require 'os'

module ApplicationHelper
	def fdate(date)
    return "" if !date
    date.strftime("%Y-%m-%d")
  end



  def fdatetime(datetime)
    return "" if !datetime
    datetime.in_time_zone("Europe/Paris").strftime("%Y-%m-%d %H:%M")
  end


  def ftime(time)
    return "" if !time
    time.strftime("%R %P")
  end


  def cpu_temp
    if OS.mac?
      %x[sysctl -n machdep.xcpm.cpu_thermal_level].to_f.round(1)
    else
      %x[/usr/bin/vcgencmd measure_temp].to_s.split("=")[1].to_f.round(1)
    end
  end


  def cpu_usage
    if OS.mac?
      `ps -A -o %cpu | awk '{s+=$1} END {print s}'`
    else
      `grep 'cpu ' /proc/stat | awk '{usage=100-($5*100)/($2+$3+$4+$5+$6+$7+$8)} END {print usage}'`.to_f.round(1)
    end
  end

  def used_memory
    if OS.mac?
      "0"
    else
      `awk '/^Mem/ {print $3}' <(free -mh)`
    end
  end

  def free_memory
    if OS.mac?
      "0"
    else
      `awk '/^Mem/ {print $2}' <(free -mh)`
    end
  end

  def voltage
    if OS.mac?
      `system_profiler SPPowerDataType | grep Voltage`.split(": ")[1].to_i / 1000
    else
      `/usr/bin/vcgencmd measure_volts`.split("=")[1].to_f.round(1)
    end
  end


  def system_info
    if OS.mac?
      "macOS 78"
    else
      `/usr/bin/lsb_release -d`.split(":")[1].strip
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
    last = Sample.where(product_reference: "Openweather2", data_type_id: 1).order(created_at: :desc).limit(1).first
    return "#{last.value}#{last.unit}" if last
    return "0°C"
  end

  def weather_humidity
    last = Sample.where(product_reference: "Openweather2", data_type_id: 2).order(created_at: :desc).limit(1).first
    return "#{last.value}#{last.unit}" if last
    return "0%"
  end
end
