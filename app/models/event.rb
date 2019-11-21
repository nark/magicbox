class Event < ApplicationRecord
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
end
