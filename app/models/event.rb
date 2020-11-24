class Event < ApplicationRecord
  belongs_to :room
  belongs_to :device
  
	enum event_type: {
    :action		=> 0,
    :alert 		=> 1,
    :cron			=> 2,
    :api			=> 3,
    :condition => 4
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
end
