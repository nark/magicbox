class AddCustomIdentifierToDevices < ActiveRecord::Migration[5.2]
  def change
  	add_column :devices, :custom_identifier, :string
  end
end
