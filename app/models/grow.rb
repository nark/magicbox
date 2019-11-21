class Grow < ApplicationRecord
  default_scope { order(end_date: :desc) }

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
  has_many :observations, dependent: :delete_all

  def nb_weeks
  	start_date.step(end_date, 7).count  
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

  def progress_percents
  	start_time = self.start_date.to_time
		end_time   = self.end_date.to_time

    return 0 if !start_time or !end_time or end_time == start_time
    return 0 if Time.now < start_time

		(((Time.now - start_time) / (end_time - start_time)) * 100.0).round
  end
end
