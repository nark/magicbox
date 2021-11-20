class CreateWeeks < ActiveRecord::Migration[5.2]
  def change
    create_table :weeks do |t|
      t.integer :week_number
      t.integer :week_type
      t.date :start_date
      t.date :end_date
      t.integer :grow_id

      t.timestamps
    end
  end
end
