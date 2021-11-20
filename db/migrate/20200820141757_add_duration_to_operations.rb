class AddDurationToOperations < ActiveRecord::Migration[5.2]
  def change
  	add_column :operations, :duration, :integer
  end
end
