class AddGramsToGrows < ActiveRecord::Migration[5.2]
  def change
  	add_column :grows, :estimated_weight_by_square_meter, :float, default: 0
  	#add_column :grows, :havested_trim_weight, :float, default: 0
  	#add_column :grows, :havested_waste_weight, :float, default: 0
  	#add_column :grows, :havested_bud_weight, :float, default: 0
  end
end
