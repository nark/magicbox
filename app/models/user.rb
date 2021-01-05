class User < ApplicationRecord
	acts_as_token_authenticatable
	
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :alert_users
  has_many :alerts, through: :alert_users

  has_many :observations
  has_many :notifications
  has_many :todos
  has_many :push_devices


  def todos_count
    todos.where(todo_status: :todo).count
  end


  def unread_notifications_count
  	notifications.where(read: false).count
  end
  

  def mark_notifications_as_read
    notifications.where(read: false).update_all(read: true)
  end


  def deliver_onesignal_notification(title, body)
    device_ids = self.push_devices.map { |e| e.device_id }

    unless device_ids.empty?
      headings = OneSignal::Notification::Headings.new(en: title)
      contents = OneSignal::Notification::Contents.new(en: body)
      included_targets = OneSignal::IncludedTargets.new(include_player_ids: device_ids)
      notification = OneSignal::Notification.new(headings: headings, contents: contents, included_targets: included_targets)
      response = OneSignal.send_notification(notification)
    end
  end
end
