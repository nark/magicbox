class Alert < ApplicationRecord
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

  has_many :notifications

  def title
    "Alert##{id}: #{data_type.name} #{operator} #{value}"
  end

  def test_alert
    self.users.each do |u|
      n = Notification.create(user_id: u.id,  alert_id: self.id)

      UserMailer.with(notification: n, user: u).notification_email.deliver_now
    end
  end

  def trigger
    triggered = false
    info = ""

    if data_type_alert?
      last_sample = Sample.where(data_type_id: data_type.id).limit(1).first

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
    end

    if triggered
      now = Time.zone.now

      #if !latest_send or latest_send <= (now - 1.hour)
        self.users.each do |u|
          n = Notification.create(user_id: u.id,  alert_id: self.id)

          UserMailer.with(notification: n, user: u).notification_email.deliver_now
        end

        self.latest_send = now
        self.save
      #end
    end
  end
end
