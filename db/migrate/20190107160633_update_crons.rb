class UpdateCrons < ActiveRecord::Migration[5.2]
  def change
  	#remove_column :crons, :period
  	#add_column :crons, :period, :integer, default: 0
  end
end
