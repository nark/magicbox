class AddGrowStatusToGrows < ActiveRecord::Migration[5.2]
  def change
  	add_column :grows, :grow_status, :integer, default: 0
  end
end
