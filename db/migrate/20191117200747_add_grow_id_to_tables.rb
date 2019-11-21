class AddGrowIdToTables < ActiveRecord::Migration[5.2]
  def change
  	add_column :subjects, :grow_id, :integer
  end
end
