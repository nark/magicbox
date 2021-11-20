module ApplicationHelper
  def product_references
    {
      sensor: [
        ["DHT11", "dht11"], 
        ["DHT22", "dht22"]
      ],
      camera: [
        ["USB Webcam", "usb_webcam"], 
        ["Raspberry Pi Camera Module v2", "rpi_camera_module_v2"],
        ["ustreamer", "ustreamer"]
      ] 
    }
  end

	def fdate(date)
    return "" if !date
    date.strftime(Setting.rails_date_format)
  end


  def fdatetime(datetime)
    return "" if !datetime
    datetime.in_time_zone(Setting.time_zone).strftime("#{Setting.rails_date_format} #{Setting.rails_time_format}")
  end


  def ftime(time)
    return "" if !time
    time.strftime(Setting.rails_time_format)
  end


  def weight_with_unit(weight)
    "#{weight || 0}#{Setting.units_weight}"
  end

  def currency_with_unit(amount)
    "#{amount || 0}#{Setting.units_currency}"
  end

  def sidebar_item(path, text, options = {}, &block)
    content_tag(:li, class: current_page?(path) ? "active" : "") do
      if block_given?
        link_to path, options do
          concat capture(&block)
          concat " #{text}"
          if options[:badge_count].present? and options[:badge_count] > 0
            concat(
              content_tag(:div, class: "float-right") do
                content_tag(:span, class: "badge badge-light") do
                  concat(options[:badge_count])
                end
              end
            )
          end
        end
      else
        link_to text, path, options
      end
    end
  end


  def issue_icon(issue)
    arrow = ""

    if issue.excess?
      arrow = "-up"
    else
      arrow = "-down"
    end

    if issue.level1?
      icon("fas", "arrow#{arrow}")
    elsif issue.level2?
      icon("fas", "arrow#{arrow}") + " " + icon("fas", "arrow#{arrow}")
    elsif issue.level3?
      icon("fas", "arrow#{arrow}") + " " + icon("fas", "arrow#{arrow}") + " " + icon("fas", "arrow#{arrow}")
    end
  end


  def time_zones
    [["Africa/Algiers", "West Central Africa"],
 ["Africa/Cairo", "Cairo"],
 ["Africa/Casablanca", "Casablanca"],
 ["Africa/Harare", "Harare"],
 ["Africa/Johannesburg", "Pretoria"],
 ["Africa/Monrovia", "Monrovia"],
 ["Africa/Nairobi", "Nairobi"],
 ["America/Argentina/Buenos_Aires", "Buenos Aires"],
 ["America/Bogota", "Bogota"],
 ["America/Caracas", "Caracas"],
 ["America/Chicago", "Central Time (US & Canada)"],
 ["America/Chihuahua", "Chihuahua"],
 ["America/Denver", "Mountain Time (US & Canada)"],
 ["America/Godthab", "Greenland"],
 ["America/Guatemala", "Central America"],
 ["America/Guyana", "Georgetown"],
 ["America/Halifax", "Atlantic Time (Canada)"],
 ["America/Indiana/Indianapolis", "Indiana (East)"],
 ["America/Juneau", "Alaska"],
 ["America/La_Paz", "La Paz"],
 ["America/Lima", "Quito"],
 ["America/Los_Angeles", "Pacific Time (US & Canada)"],
 ["America/Mazatlan", "Mazatlan"],
 ["America/Mexico_City", "Mexico City"],
 ["America/Monterrey", "Monterrey"],
 ["America/Montevideo", "Montevideo"],
 ["America/New_York", "Eastern Time (US & Canada)"],
 ["America/Phoenix", "Arizona"],
 ["America/Regina", "Saskatchewan"],
 ["America/Santiago", "Santiago"],
 ["America/Sao_Paulo", "Brasilia"],
 ["America/St_Johns", "Newfoundland"],
 ["America/Tijuana", "Tijuana"],
 ["Asia/Almaty", "Almaty"],
 ["Asia/Baghdad", "Baghdad"],
 ["Asia/Baku", "Baku"],
 ["Asia/Bangkok", "Hanoi"],
 ["Asia/Chongqing", "Chongqing"],
 ["Asia/Colombo", "Sri Jayawardenepura"],
 ["Asia/Dhaka", "Dhaka"],
 ["Asia/Hong_Kong", "Hong Kong"],
 ["Asia/Irkutsk", "Irkutsk"],
 ["Asia/Jakarta", "Jakarta"],
 ["Asia/Jerusalem", "Jerusalem"],
 ["Asia/Kabul", "Kabul"],
 ["Asia/Kamchatka", "Kamchatka"],
 ["Asia/Karachi", "Karachi"],
 ["Asia/Kathmandu", "Kathmandu"],
 ["Asia/Kolkata", "New Delhi"],
 ["Asia/Krasnoyarsk", "Krasnoyarsk"],
 ["Asia/Kuala_Lumpur", "Kuala Lumpur"],
 ["Asia/Kuwait", "Kuwait"],
 ["Asia/Magadan", "Magadan"],
 ["Asia/Muscat", "Muscat"],
 ["Asia/Novosibirsk", "Novosibirsk"],
 ["Asia/Rangoon", "Rangoon"],
 ["Asia/Riyadh", "Riyadh"],
 ["Asia/Seoul", "Seoul"],
 ["Asia/Shanghai", "Beijing"],
 ["Asia/Singapore", "Singapore"],
 ["Asia/Taipei", "Taipei"],
 ["Asia/Tashkent", "Tashkent"],
 ["Asia/Tbilisi", "Tbilisi"],
 ["Asia/Tehran", "Tehran"],
 ["Asia/Tokyo", "Tokyo"],
 ["Asia/Ulaanbaatar", "Ulaanbaatar"],
 ["Asia/Urumqi", "Urumqi"],
 ["Asia/Vladivostok", "Vladivostok"],
 ["Asia/Yakutsk", "Yakutsk"],
 ["Asia/Yekaterinburg", "Ekaterinburg"],
 ["Asia/Yerevan", "Yerevan"],
 ["Atlantic/Azores", "Azores"],
 ["Atlantic/Cape_Verde", "Cape Verde Is."],
 ["Atlantic/South_Georgia", "Mid-Atlantic"],
 ["Australia/Adelaide", "Adelaide"],
 ["Australia/Brisbane", "Brisbane"],
 ["Australia/Darwin", "Darwin"],
 ["Australia/Hobart", "Hobart"],
 ["Australia/Melbourne", "Melbourne"],
 ["Australia/Perth", "Perth"],
 ["Australia/Sydney", "Sydney"],
 ["Etc/UTC", "UTC"],
 ["Europe/Amsterdam", "Amsterdam"],
 ["Europe/Athens", "Athens"],
 ["Europe/Belgrade", "Belgrade"],
 ["Europe/Berlin", "Bern"],
 ["Europe/Bratislava", "Bratislava"],
 ["Europe/Brussels", "Brussels"],
 ["Europe/Bucharest", "Bucharest"],
 ["Europe/Budapest", "Budapest"],
 ["Europe/Copenhagen", "Copenhagen"],
 ["Europe/Dublin", "Dublin"],
 ["Europe/Helsinki", "Helsinki"],
 ["Europe/Istanbul", "Istanbul"],
 ["Europe/Kiev", "Kyiv"],
 ["Europe/Lisbon", "Lisbon"],
 ["Europe/Ljubljana", "Ljubljana"],
 ["Europe/London", "London"],
 ["Europe/Madrid", "Madrid"],
 ["Europe/Minsk", "Minsk"],
 ["Europe/Moscow", "Volgograd"],
 ["Europe/Paris", "Paris"],
 ["Europe/Prague", "Prague"],
 ["Europe/Riga", "Riga"],
 ["Europe/Rome", "Rome"],
 ["Europe/Sarajevo", "Sarajevo"],
 ["Europe/Skopje", "Skopje"],
 ["Europe/Sofia", "Sofia"],
 ["Europe/Stockholm", "Stockholm"],
 ["Europe/Tallinn", "Tallinn"],
 ["Europe/Vienna", "Vienna"],
 ["Europe/Vilnius", "Vilnius"],
 ["Europe/Warsaw", "Warsaw"],
 ["Europe/Zagreb", "Zagreb"],
 ["Pacific/Apia", "Samoa"],
 ["Pacific/Auckland", "Wellington"],
 ["Pacific/Chatham", "Chatham Is."],
 ["Pacific/Fakaofo", "Tokelau Is."],
 ["Pacific/Fiji", "Fiji"],
 ["Pacific/Guadalcanal", "Solomon Is."],
 ["Pacific/Guam", "Guam"],
 ["Pacific/Honolulu", "Hawaii"],
 ["Pacific/Majuro", "Marshall Is."],
 ["Pacific/Midway", "Midway Island"],
 ["Pacific/Noumea", "New Caledonia"],
 ["Pacific/Pago_Pago", "American Samoa"],
 ["Pacific/Port_Moresby", "Port Moresby"],
 ["Pacific/Tongatapu", "Nuku'alofa"]]
  end
end
