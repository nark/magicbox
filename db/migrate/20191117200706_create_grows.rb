class CreateGrows < ActiveRecord::Migration[5.2]
  def change
    create_table :grows do |t|
      t.text :description
      t.date :start_date
      t.date :end_date
      t.integer :substrate
      t.integer :flowering

      t.timestamps
    end
  end
end
