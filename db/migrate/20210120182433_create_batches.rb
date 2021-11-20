class CreateBatches < ActiveRecord::Migration[5.2]
  def change
    create_table :batches do |t|
      t.integer :grow_id
      t.integer :harvest_id
      t.string :name
      t.float :total_weight
      t.float :batch_weight
      t.integer :batch_count

      t.timestamps
    end
  end
end
