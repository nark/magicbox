class AddNotificationContextToNotifications < ActiveRecord::Migration[5.2]
  def change
  	add_reference :notifications, :notified, polymorphic: true, index: true
  end
end
