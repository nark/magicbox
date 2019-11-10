class CreateConditions < ActiveRecord::Migration[5.2]
  def change
    create_table :conditions do |t|
      t.string :name
      t.integer :data_type_id
      t.integer :predicate
      t.integer :target_value
      t.time :start_time
      t.time :end_time
      t.integer :scenario_id

      t.timestamps
    end
  end
end
