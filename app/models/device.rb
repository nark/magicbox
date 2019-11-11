class Device < ApplicationRecord
	enum device_type: {
    :unknow    	=> 0,
    :sensor	  	=> 1,
    :fan				=> 2,
    :water_pump => 3,
    :air_pump		=> 4,
    :light			=> 5
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

  has_many :devices_data_types
  has_many :data_types, through: :devices_data_types, source: :data_type
  has_many :crons

  def start(options={})
    default_options = {
      :event_type => :action,
      :event => true
    }

    options = options.reverse_merge(default_options)
    state_changed = self.device_state != :on

    `python scripts/relay.py #{self.pin_number} 1`
    self.device_state = :on
    self.save

   if state_changed and options[:event_type] == :cron
      Event.create(event_type: :cron, message: "#{self.name} started", data: { device_id: self.id })
    else
      if options[:event]
        Event.create(event_type: :action, message: "#{self.name} started", data: { device_id: self.id })
      end
    end
  end

  def stop(options={})
    default_options = {
      :event_type => :action,
      :event => true
    }

    options = options.reverse_merge(default_options)
    state_changed = self.device_state != :off

    `python scripts/relay.py #{self.pin_number} 0`
    self.device_state = :off
    self.save

    if state_changed and options[:event_type] == :cron
      Event.create(event_type: :cron, message: "#{self.name} stopped", data: { device_id: self.id })
    else
      if options[:event]
        Event.create(event_type: :action, message: "#{self.name} stopped", data: { device_id: self.id })
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
