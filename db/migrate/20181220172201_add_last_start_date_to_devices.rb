class AddLastStartDateToDevices < ActiveRecord::Migration[5.2]
  def change
  	add_column :devices, :last_start_date, :datetime
  end
end
