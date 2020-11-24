class Cron < ApplicationRecord
	belongs_to :scenario
	belongs_to :device

	enum cron_type: {
    :every 				=> 0,
    :between			=> 1
  }

  enum period: {
  	:any_time 			=> 1,
    :minute 				=> 2,
    :hour						=> 3,
    :day						=> 4
  }

  def execute_command
    if command == "start"
      logger.info "\n  -> Start #{device.name}\n"
      
      device.start(event_type: :cron, event: false)
      self.last_exec_time = Time.now
      self.save!

      logger.info "#{duration} #{duration.class}"

      if duration and duration != 0
        logger.info "\n   -> #{device.name} will stop in #{duration} sec.\n"
        CommandJob.perform_in(duration.seconds, device.id, "stop")
      end
      return
    end


    if command == "stop"
      logger.info "\n  -> Stop #{device.name}\n"
      
      device.stop(event_type: :cron, event: false)
      self.last_exec_time = Time.now
      self.save!

      if duration and duration != 0
        logger.info "\n   -> #{device.name} will start in #{duration} sec.\n"
        CommandJob.perform_in(duration.seconds, device.id, "start")
      end

      return
    end
  end

  def is_yesterday(now)

    if start_time.hour < end_time.hour
      return false
    end

    if now.hour < end_time.hour
      return true
    end

    if now.hour > end_time.hour
      return false
    end

    if now.min < end_time.min
      return  true
    end

    return false
  end

  def is_tomorrow
    if start_time.hour > end_time.hour
      return true
    end

    if start_time.hour < end_time.hour
      return false
    end

    if start_time.min > end_time.min 
      return true
    end

    if start_time.min < end_time.min
      return false
    end

    return true
  end

  def cron_between_is_valid(now)
    between = false

    if !start_time or !end_time
      return true
    end

    start_date  = now.change({ hour: start_time.hour, min: start_time.min, sec: start_time.sec })
    end_date    = now.change({ hour: end_time.hour, min: end_time.min, sec: end_time.sec })

    start_is_yesterday = is_yesterday(now)

    if start_is_yesterday
      start_date = start_date - 1.day
    elsif is_tomorrow
      end_date = end_date + 1.day
    end

    between = now.between?(start_date, end_date)

    logger.info "\n#{device.name} cron_between_is_valid: #{between}, #{now}, #{start_date}, #{end_date}\n"

    return between
  end

  def need_check_between
    if !start_time
      return false
    end

    if !end_time
      return false
    end

    return true
  end
  
  def has_valid_period(now)
    #return true if !last_exec_time

    #logger.info last_exec_time

    seconds_elapsed = now - last_exec_time

    #logger.info seconds_elapsed
    #logger.info time_value.minutes

    if minute?
      return seconds_elapsed >= time_value.minutes
    end

    if hour?
      return seconds_elapsed >= time_value.hours
    end

    if day?
      return seconds_elapsed >= time_value.days
    end

    return false
  end
end
