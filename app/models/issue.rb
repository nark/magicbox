class Issue < ApplicationRecord
	attr_accessor :category_id
	
	belongs_to :resource
	#belongs_to :subject, optional: true
	belongs_to :observation

	enum severity: {
    :level1 => 0,
    :level2 => 1,
    :level3 => 2
  }

	enum issue_status: {
    :open => 0,
    :closed => 1
  }

  enum issue_type: {
    :excess => 0,
    :deficiency => 1
  }

  def url
    #Rails.application.routes.url_helpers.grow_path(observation.grow)
  end

  def text
    "#{resource.name} #{issue_type} #{severity}"
  end


  def color
    return "coral"
  end


  def start_date
    created_at
  end


  def end_date
    start_date + 1.hour
  end
end
