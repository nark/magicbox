class AddPriceToBatches < ActiveRecord::Migration[5.2]
  def change
  	add_column :batches, :price_per_weight, :float, default: 0
  	add_column :batches, :batch_price, 			:float, default: 0
  end
end
