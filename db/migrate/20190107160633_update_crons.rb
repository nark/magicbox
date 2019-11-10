class UpdateCrons < ActiveRecord::Migration[5.2]
  def change
  	change_column :crons, :period, :integer
  end
end
