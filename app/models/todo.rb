class Todo < ApplicationRecord
  include ActionView::Helpers::TextHelper
  include ApplicationHelper

  belongs_to :user
  
	default_scope { order('date ASC') }

	enum todo_status: {
  	:todo		=> 0,
    :done		=> 1
  }

  has_many :notifications, as: :notifiable, dependent: :delete_all

  validates :body, presence: true

  def url
    Rails.application.routes.url_helpers.todos_path
  end

  def title
    "TODO: Scheduled at #{fdatetime(date)}"
  end

  def email_subject
    "#{title}"
  end

  def notifiable_color
    "warning"
  end

  def notifiable_icon
    "clock"
  end

  def notifiable_url
    Setting.app_hostname + Rails.application.routes.url_helpers.todos_path
  end

  def text
    body
  end

  def message
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


  def is_late?
    date < DateTime.now
  end


  def self.notify
    now   = DateTime.now
    todos = Todo.where(todo_status: :todo).where('date < ?', now)
    #todos = todos.where('notified_date IS NULL OR notified_date < ?', now - todo.renotify_every_minute)
    logger.info todos.count

    todos.each do |todo|
      logger.info "todo.notified_date : #{todo.notified_date}"
      logger.info "now - todo.renotify_every_minute : #{now - todo.renotify_every_minute.minutes}"
      if todo.notified_date == nil or 
         todo.notified_date < (now - todo.renotify_every_minute.minutes)
        
        if todo.notify_email? or 
           todo.notify_push?
          Notification.create(
              user: todo.user, 
              notify_email: todo.notify_email?, 
              notify_push: todo.notify_push?, 
              notifiable: todo).notify()
        
          todo.notified_date = now
          todo.save
        end
      end
    end
  end
end
