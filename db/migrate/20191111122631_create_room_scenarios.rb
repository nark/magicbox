class CreateRoomScenarios < ActiveRecord::Migration[5.2]
  def change
    create_table :room_scenarios do |t|
      t.references :room, foreign_key: true
      t.references :scenario, foreign_key: true

      t.timestamps
    end
  end
end
