require 'mb_logger'

class Alert < ApplicationRecord
  include ActionView::Helpers::TextHelper

	enum alert_type: {
    :data_type_alert => 0,
    :resource_alert  => 1
  }

  enum operator: {
    :equal 							=> 0,
    :not_equal 					=> 1,
    :lesser 						=> 2,
    :greater 						=> 3,
    :lesser_or_equal 		=> 4,
    :greater_or_equal 	=> 5,
    # :like               => 6,
    # :not_like           => 7,
    # :contain 						=> 8,
    # :not_contain 				=> 9,
    # :start_with 				=> 10,
    # :not_start_with 		=> 11,
    # :end_with 					=> 12,
    # :not_end_with 			=> 13
  }

  belongs_to :data_type, optional: true
  belongs_to :resource, optional: true

  has_many :alert_users
  has_many :users, through: :alert_users

  has_many :alert_push_users, class_name: "AlertPushUser"
  has_many :push_users, through: :alert_push_users, source: :user

  has_many :notifications, as: :notifiable, dependent: :delete_all
  has_many :events, :as => :eventable, dependent: :destroy

  validates :value, presence: true
  validates :message, presence: true

  def title
    "Alert"
  end


  def email_subject
    "ALERT: #{title}"
  end


  def notifiable_color
    "danger"
  end


  def notifiable_icon
    "exclamation-triangle"
  end


  def notifiable_url
    Setting.app_hostname + Rails.application.routes.url_helpers.notifications_path
  end


  def test_alert
    trigger
    # self.users.each do |u|
    #   Notification.create!(
    #     user: u, 
    #     notify_email: true, 
    #     notify_push: push_enabled, 
    #     notifiable: self).notify()
    # end
  end

  def self.trigger
    MB_LOGGER.info("# Start Trigger Alerts ############")
    Alert.all.each do |alert|
      alert.trigger
    end
    MB_LOGGER.info("# End Trigger Alerts ##############")
  end

  def trigger
    return unless enabled?

    context_object = nil
    triggered = false
    info = ""

    if data_type_alert?
      last_sample = Sample.where(data_type_id: data_type.id).limit(1).first
      context_object = last_sample.device

      case operator.to_sym
      when :equal       
        triggered = last_sample.value.to_f == value  
        info = "#{last_sample.value.to_f} equal #{value}" 
      when :not_equal      
        triggered = last_sample.value.to_f != value  
        info = "#{last_sample.value.to_f} not_equal #{value}"  
      when :lesser   
        triggered = last_sample.value.to_f < value  
        info = "#{last_sample.value.to_f} lesser #{value}"     
      when :greater   
        triggered = last_sample.value.to_f > value  
        info = "#{last_sample.value.to_f} greater #{value}"      
      when :lesser_or_equal 
        triggered = last_sample.value.to_f <= value
        info = "#{last_sample.value.to_f} lesser_or_equal #{value}"
      when :greater_or_equal
        triggered = last_sample.value.to_f >= value
        info = "#{last_sample.value.to_f} greater_or_equal #{value}"
      # when :like   
      #   triggered = false      
      #   info = "false"  
      # when :not_like   
      #   triggered = false      
      #   info = "false"  
      # when :contain   
      #   triggered = false      
      #   info = "false"  
      # when :not_contain
      #   triggered = false     
      #   info = "false"  
      # when :start_with   
      #   triggered = false   
      #   info = "false"
      # when :not_start_with  
      #   triggered = false
      #   info = "false"
      # when :end_with    
      #   triggered = false   
      #   info = "false" 
      # when :not_end_with 
      #   triggered = false
      #   info = "false"
      end

    elsif resource_alert?
      last_data = ResourceData.where(resource_id: resource.id).order("created_at").last
      context_object = last_data.observation
    end

    if triggered
      MB_LOGGER.info("  -> Alert triggered: #{self.message} - #{self.users.count} users")

      Event.create!(event_type: :alert, message: self.message, eventable: self)

      now = Time.zone.now

      #if !latest_send or latest_send <= (now - 1.hour)

      self.users.each do |u|
        MB_LOGGER.info("  -> Before notify : #{u.inspect}")

        n = Notification.create!(
          user: u, 
          notify_email: true, 
          notify_push: push_enabled, 
          notifiable: self,
          notified: context_object)

        MB_LOGGER.info("  -> Notification : #{n.inspect}")

        n.notify()
      end

      # self.latest_send = now
      # self.save
      #end
    end
  end
end
