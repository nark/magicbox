class AddIndexesToSamples < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!
  
  def change
    add_index :samples, :data_type_id, :algorithm => :concurrently
    add_index :samples, :created_at, :algorithm => :concurrently
  end
end
