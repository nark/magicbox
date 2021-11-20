class NotificationBecomeNotifiable < ActiveRecord::Migration[5.2]
  def change
  	rename_column :notifications, :alert_id, :notifiable_id
  	add_column :notifications, :notifiable_type, :string, default: "Alert"
  end
end
