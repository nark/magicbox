class CreateCrons < ActiveRecord::Migration[5.2]
  def change
    create_table :crons do |t|
      t.integer :scenario_id
      t.integer :device_id
      t.string :command
      t.string :period
      t.string :time
      t.integer :delay
      t.integer :repeats

      t.timestamps
    end
  end
end
