class Todo < ApplicationRecord
	default_scope { order('date ASC') }

	enum todo_status: {
  	:todo		=> 0,
    :done		=> 1
  }

  def url
    Rails.application.routes.url_helpers.todos_path
  end

  def text
    body
  end


  def color
    return "orange" if self.todo?
    return "lightgray" if self.done?
  end


  def start_date
    date
  end


  def end_date
    date + 1.hour
  end
end
