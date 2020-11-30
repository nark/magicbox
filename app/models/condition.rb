class Condition < ApplicationRecord
  include ApplicationHelper
	belongs_to :condition_group
	belongs_to :data_type

  enum condition_type: {
    date:           0,
    data_type:      1,
    resource:       2,
    device_state:   3
  }

  enum logic: {
    and_operator: 0,
    or_operator:  1
  }


  def self.condition_type_text(c)
    return "Time" if c == :date
    return c.to_s.titleize
  end


  def self.logic_text(l)
    return "AND" if l == :and_operator
    return "OR"
  end


  def check_condition(room)
    if date?
      now = Time.now

      check_between = self.need_check_between()
      between = self.cron_between_is_valid(now)

      if !check_between or (check_between and between)
        return true
      end
    elsif data_type?
      return true if self.check_data_type_for_room(room)

    end

    return false
  end


  def condition_text
    if date?
      return "<b>current time (#{ftime(Time.now)})</b> is between <b>#{ftime(start_time)}</b> and <b>#{ftime(end_time)}</b>"
    elsif data_type?
      return "<b>#{data_type.name}</b> is <b>#{[[">=", 0], ["<=", 1]][predicate].first}</b> to <b>#{target_value}</b>"
    end
    return "unknow condition"
  end


	def check_data_type_for_room(room)
		return true if !data_type

		sample = room.samples.where(data_type_id: data_type.id).order("created_at").first
		return true if !sample

    #logger.info "check_data_type_for_room : #{sample.inspect}"

		# [">=", 0], ["<=", 1]
		if predicate == 0
			return true if sample.value.to_f >= target_value.to_f
		elsif predicate == 1
			return true if sample.value.to_f <= target_value.to_f
		end
				
		return false
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

    if start_time == end_time
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
