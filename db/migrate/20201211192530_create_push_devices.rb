class CreatePushDevices < ActiveRecord::Migration[5.2]
  def change
    create_table :push_devices do |t|
      t.string :device_id
      t.integer :user_id

      t.timestamps
    end
  end
end
