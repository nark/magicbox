class CreateOperations < ActiveRecord::Migration[5.2]
  def change
    create_table :operations do |t|
      t.string :command
      t.integer :delay
      t.integer :retries
      t.integer :device_id
      t.string :description
      t.integer :condition_id

      t.timestamps
    end
  end
end
