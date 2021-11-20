class UpdateWeeksColumnsInGrows < ActiveRecord::Migration[5.2]
  def change
  	add_column :grows, :seedling_weeks, :integer, default: 1
  	add_column :grows, :vegging_weeks, :integer, default: 2
  	add_column :grows, :flowering_weeks, :integer, default: 7
  	add_column :grows, :flushing_weeks, :integer, default: 1
  	add_column :grows, :drying_weeks, :integer, default: 1
  	add_column :grows, :curing_weeks, :integer, default: 3

  	remove_column :grows, :end_date
  end
end
