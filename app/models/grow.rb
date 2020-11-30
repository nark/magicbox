class Grow < ApplicationRecord
  default_scope { order(start_date: :desc) }

  enum grow_status: {
    :scheduled  => 0,
    :seedling   => 1,
    :vegging    => 2,
    :blooming   => 3,
    :flushing   => 4,
    :drying     => 5,
    :curing     => 6,
    :done       => 7,
    :aborted    => 8
  }

	enum substrate: {
    :soil 	=> 0,
    :coco 	=> 1,
    :hydro 	=> 2,
    :aero 	=> 3
  }

  enum flowering: {
    :photoperiodic 	=> 0,
    :autoflowering 	=> 1
  }

  has_many :subjects, dependent: :delete_all
  has_many :weeks, dependent: :delete_all
  has_many :observations, dependent: :delete_all

  def name
    "##{id} - #{description}"
  end

  def active_subjects
    self.subjects.joins(:grow).where.not('grows.grow_status': [:done, :aborted])
  end

  def nb_weeks
  	start_date.step(end_date, 7).count  
  end

  def status_badge_class
    if done?
      return "badge-light border"
    elsif aborted?
      return "badge-danger"
    elsif seedling? or vegging? or blooming?
      return "badge-success"
    elsif flushing?
      return "badge-info"
    elsif drying? or curing?
      return "badge-warning"
    else
      return "badge-primary"
    end
  end

  def generate_weeks
    weeks.destroy_all

    # create weeks
    sdate = self.start_date
    edate = sdate + 7.days
    index = 0

    self.seedling_weeks.times do |i|
      self.generate_weeks_with(:seedling, i, sdate, edate)
      sdate = sdate + 7.days
      edate = sdate + 7.days
      index += 1
    end

    self.vegging_weeks.times do |i|
      self.generate_weeks_with(:seedling, index, sdate, edate)
      sdate = sdate + 7.days
      edate = sdate + 7.days
      index += 1
    end

    self.flowering_weeks.times do |i|
      self.generate_weeks_with(:blooming, index, sdate, edate)
      sdate = sdate + 7.days
      edate = sdate + 7.days
      index += 1
    end

    self.drying_weeks.times do |i|
      self.generate_weeks_with(:drying, index, sdate, edate)
      sdate = sdate + 7.days
      edate = sdate + 7.days
      index += 1
    end

    self.curing_weeks.times do |i|
      self.generate_weeks_with(:curing, index, sdate, edate)
      sdate = sdate + 7.days
      edate = sdate + 7.days
      index += 1
    end
  end

  def generate_weeks_with(type, index, start_date, end_date)
    Week.create(
      grow_id: self.id, 
      week_type: type, 
      week_number: index+1, 
      start_date: start_date, 
      end_date: end_date)
  end

  def end_date
    return self.weeks.last.end_date if self.weeks.last
    return self.start_date
  end

  def current_week
    now = Date.today
    #puts "#{start_date} < #{now} < #{end_date}"
    #return true if now >= start_date && now <= end_date
    return self.weeks.where('? >= start_date AND ? <= end_date', now, now).first
  end

  def bg_color_for_week(week_index)
    days = week_index * 7
    week_start_date = start_date + days.days
    week_end_date = week_start_date + 7.days
    now = Date.today

    if now > week_end_date 
      return "success"

    elsif week_start_date < now and now < week_end_date
      return "primary"
    end 

    return "secondary"
  end


  def progress_color
    now = Date.today

    return "success" if done?
    return "danger" if now > end_date
    return "primary"
  end

  def progress_percents
  	start_time = self.start_date.to_time
		end_time   = self.end_date.to_time

    return 100 if done?
    return 0 if !start_time or !end_time or end_time == start_time
    return 0 if Time.now < start_time

		r = (((Time.now - start_time) / (end_time - start_time)) * 100.0).round
    return 100 if r > 100
    return r
  end
end
