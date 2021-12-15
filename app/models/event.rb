class Event < ApplicationRecord
  include ActionView::Helpers::UrlHelper

  default_scope { order(created_at: :desc) }

  belongs_to :eventable, polymorphic: true

  belongs_to :room, optional: true
  belongs_to :device, optional: true
  belongs_to :user, optional: true

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


  def eventable_link
    ActionView::Base.send(:include, Rails.application.routes.url_helpers)

    if eventable_type == "Room"
      ActionController::Base.helpers.link_to(eventable.name, eventable)

    elsif eventable_type == "Device"
      ActionController::Base.helpers.link_to(eventable.name, [eventable.room, eventable])

    elsif eventable_type == "Subject"
      ActionController::Base.helpers.link_to(eventable.name, [eventable.grow, eventable])

    elsif eventable_type == "Observation"
      ActionController::Base.helpers.link_to(eventable.grow.name, [eventable.grow])

    end
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
