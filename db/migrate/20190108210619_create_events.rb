class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.integer :event_type
      t.text :message
      t.json :data

      t.timestamps
    end
  end
end
