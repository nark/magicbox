class CreateResourceData < ActiveRecord::Migration[5.2]
  def change
    create_table :resource_datas do |t|
      t.integer :resource_id
      t.integer :observation_id
      t.integer :subject_id
      t.string :value
      t.string :unit

      t.timestamps
    end
  end
end
