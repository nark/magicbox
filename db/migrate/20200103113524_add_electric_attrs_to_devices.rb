class AddElectricAttrsToDevices < ActiveRecord::Migration[5.2]
  def change
  	add_column :devices, :watts, :float, default: 0.0
  	add_column :devices, :volts, :float, default: 0.0
  	add_column :devices, :amperes, :float, default: 0.0
  end
end
