class AddUseDurationToDevices < ActiveRecord::Migration[5.2]
  def change
  	add_column :devices, :use_duration, :boolean, default: false
  end
end
