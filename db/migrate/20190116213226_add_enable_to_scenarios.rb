class AddEnableToScenarios < ActiveRecord::Migration[5.2]
  def change
  	add_column :scenarios, :enabled, :boolean, default: false
  end
end
