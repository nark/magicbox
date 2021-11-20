class AddBatchTypeToBatches < ActiveRecord::Migration[5.2]
  def change
  	add_column :batches, :batch_type, :integer, default: 0
  end
end
