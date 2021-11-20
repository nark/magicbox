class UpdateOperations < ActiveRecord::Migration[5.2]
  def change
  	remove_column :operations, :condition_id

  	add_column :operations, :condition_group_id, :integer
  end
end
