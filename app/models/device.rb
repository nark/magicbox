class Device < ApplicationRecord
	enum device_type: {
    :unknow    	=> 0,
    :sensor	  	=> 1,
    :fan				=> 2,
    :water_pump => 3,
    :air_pump		=> 4,
    :light			=> 5,
    :camera     => 6
  }

  enum device_state: {
    :off    	  => 0,
    :on 	  	  => 1,
    :foo 	 	  	=> 2,
    :starting   => 3,
    :stopping   => 4
  }

  enum pin_type: {
    :digital		=> 0,
    :analog 		=> 1
  }

  belongs_to :room

  has_many :samples
  has_many :events

  has_many :devices_data_types
  has_many :data_types, through: :devices_data_types, source: :data_type
  has_many :operations

  def last_sample(data_type)
    samples.where(data_type: data_type).order(created_at: :desc).limit(1).first
  end


  def start(options={})
    default_options = {
      :event_type => :action,
      :event => true
    }

    options = options.reverse_merge(default_options)
    state_changed = self.off?

    logger.info options

    begin
      RPi::GPIO.set_numbering :bcm

      sleep 1

      RPi::GPIO.setup self.pin_number, :as => :output, :initialize => :high

      self.device_state = :on
      self.save

      if self.use_duration 
        sleep self.default_duration

        RPi::GPIO.setup self.pin_number, :as => :output, :initialize => :low

        self.device_state = :off
        self.save

        Event.create(event_type: options[:event_type], message: "#{self.name} ran #{self.default_duration} sec.", device_id: self.id, room_id: self.room.id)
      else 
        if options[:event_type] == :cron
          if state_changed
            Event.create(event_type: :cron, message: "#{self.name} started", device_id: self.id, room_id: self.room.id)
          end  
        else 
          if options[:event]
            Event.create(event_type: :action, message: "#{self.name} started", device_id: self.id, room_id: self.room.id)
          end
        end
      end

      return true
    rescue Exception => e
      return e
    end
    
    return false
  end


  def stop(options={})
    default_options = {
      :event_type => :action,
      :event => true
    }

    options = options.reverse_merge(default_options)
    state_changed = self.on?

    logger.info options

    begin
      RPi::GPIO.set_numbering :bcm
      sleep 1
      RPi::GPIO.setup self.pin_number, :as => :output, :initialize => :low

      self.device_state = :off
      self.save
  
      if options[:event_type] == :cron
        if state_changed
          Event.create(event_type: :cron, message: "#{self.name} stopped", device_id: self.id, room_id: self.room.id)
        end
      else
        if options[:event]
          Event.create(event_type: :action, message: "#{self.name} stopped", device_id: self.id, room_id: self.room.id)
        end
      end
      return true
    rescue Exception => e
      return e
    end
    
    return false
  end


  def query_sensor
    if sensor? and pin_number > 0      
      if product_reference == "dht11"
        require 'dht11'
 
        dht = DHT11::Sensor.new(pin_number)
        sleep 4
        result = dht.read
        sleep 4

        logger.info "!!! query_sensor : #{result.temperature} #{result.humidity}"
        logger.info "!!! #{result.inspect}"

        unless result.temperature.nan? and result.humidity.nan?
          temp_dt = DataType.find_by(name: "temperature")
          hum_dt  = DataType.find_by(name: "humidity")

          # yeah, add data_types to device here if needed
          data_types << temp_dt if !data_types.include? temp_dt
          data_types << hum_dt  if !data_types.include? hum_dt

          Sample.create(
            device_id: self.id,
            product_reference: self.product_reference,
            data_type_id: temp_dt.id,
            value: result.temperature,
            category_name: "sensor",
            html_color: "coral",
            unit: "°C")

          Sample.create(
            device_id: self.id,
            product_reference: self.product_reference,
            data_type_id: hum_dt.id,
            value: result.humidity,
            category_name: "sensor",
            html_color: "lightblue",
            unit: "%")
        end
      end
    end
  end


  def state_color
    if off?
      return "danger"
    elsif on?
      return "success"
    elsif foo?
      return "secondary"
    elsif starting? or stopping?
      return "warning"
    end
  end


  def pin_color
    if digital?
      return "info"
    elsif analog?
      return "success"
    end
  end

  def data_types_string
    data_types.map { |e| e.name.titleize  }.join(", ")
  end
end
