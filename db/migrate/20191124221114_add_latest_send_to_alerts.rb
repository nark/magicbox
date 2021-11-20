class AddLatestSendToAlerts < ActiveRecord::Migration[5.2]
  def change
  	add_column :alerts, :latest_send, :datetime
  end
end
