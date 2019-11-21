class CreateObservations < ActiveRecord::Migration[5.2]
  def change
    create_table :observations do |t|
      t.integer :user_id
      t.integer :grow_id
      t.integer :room_id
      t.integer :subject_id
      t.text :body
      t.float :water, default: 0.0
      t.float :nutrients, default: 0.0

      t.timestamps
    end
  end
end
