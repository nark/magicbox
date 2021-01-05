class Event < ApplicationRecord
  default_scope { order(created_at: :desc) }

  belongs_to :room
  belongs_to :device
  
	enum event_type: {
    :action		=> 0,
    :alert 		=> 1,
    :cron			=> 2,
    :api			=> 3
  }

  def badge_class
  	if action?
  		"secondary"
  	elsif alert?
  		"warning"
  	elsif cron?
  		"info"
  	elsif api?
  		"success"
  	end
  end

  def text
    "#{event_type}: #{message}"
  end 

  def start_date
    created_at
  end

  def end_date
    start_date + 1.hour
  end

  def color
    return "lightblue"
  end


  def self.search(params)
    events = Event.all

    if params[:message].present?
      events = events.where('message iLIKE ?', "%#{params[:message]}%")
    end

    if params[:event_type].present?
      events = events.where(event_type: params[:event_type])
    end

    if params[:room_id].present?
      events = events.where(room_id: params[:room_id])
    end

    if params[:device_id].present?
      events = events.where(device_id: params[:device_id])
    end

    return events
  end
end
