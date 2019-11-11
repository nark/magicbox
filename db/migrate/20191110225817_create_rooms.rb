class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.string :name
      t.integer :room_type
      t.integer :length
      t.integer :width
      t.integer :height

      t.timestamps
    end
  end
end
