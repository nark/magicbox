class AddNotificationTypeToNotifications < ActiveRecord::Migration[5.2]
  def change
  	add_column :notifications, :notify_email, :boolean, default: true
  	add_column :notifications, :notify_push, :boolean, default: true
  	remove_column :notifications, :email_sent
  end
end
