class CreateConditionGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :condition_groups do |t|
      t.integer :scenario_id
      t.string :name
      t.boolean :enabled

      t.timestamps
    end
  end
end
