class AddPinManagementToDevices < ActiveRecord::Migration[5.2]
  def change
  	add_column :devices, :pin_number, :integer, default: 0
  	add_column :devices, :pin_type, :integer, default: 0
  end
end
