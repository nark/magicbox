class AddDurationToDevices < ActiveRecord::Migration[5.2]
  def change
  	add_column :devices, :default_duration, :integer, default: 1000
  end
end
