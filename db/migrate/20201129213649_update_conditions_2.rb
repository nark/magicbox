class UpdateConditions2 < ActiveRecord::Migration[5.2]
  def change
  	remove_column :conditions, :name
  	remove_column :conditions, :scenario_id

  	add_column :conditions, :condition_group_id, :integer
  	add_column :conditions, :condition_type, :integer, default: 0
  	add_column :conditions, :logic, :integer, default: 0
  end
end
