class AddDurationToConditions < ActiveRecord::Migration[5.2]
  def change
  	add_column :conditions, :duration, :integer
  end
end
