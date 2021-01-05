class AddAttrsToAlerts < ActiveRecord::Migration[5.2]
  def change
  	add_column :alerts, :enabled, :boolean, default: true
  	add_column :alerts, :push_enabled, :boolean, default: false
  end
end
