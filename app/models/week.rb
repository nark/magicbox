class Week < ApplicationRecord
  default_scope { order(start_date: :desc) }
  
	belongs_to :grow

	enum week_type: {
    :seedling   => 0,
    :vegging    => 1,
    :flowering  => 2,
    :flushing   => 3,
    :drying     => 4,
    :curing     => 5
  }


  def text
    "#{grow.description} - Week ##{week_number} (#{week_type})"
  end


  def url
    Rails.application.routes.url_helpers.grow_path(grow)
  end

  def color
    html_color
  end


  def start_time
    start_date
  end


  def end_time
    end_date
  end


  def progress_border_color
    now = Date.today

    if now < start_date
      return "border-secondary"
    elsif now > end_date
      return "border-light"
    else
      return "border-primary"
    end   
  end


  def is_current?
    now = Date.today
    puts "#{start_date} < #{now} < #{end_date}"
    return true if now >= start_date && now <= end_date
    return false
  end


  def html_color
  	case week_type.to_sym
  	when :seedling
  		return "lightgreen"
		when :vegging  
			return "#2ECC71"
		when :flowering 
			return "#CE93D8"
		when :flushing 
			return "blue"
		when :drying   
			return "maron"
		when :curing   
 			return "lightgray"
  	end
  end
end
