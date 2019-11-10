class CreateSamples < ActiveRecord::Migration[5.2]
  def change
    create_table :samples do |t|
      t.string :product_reference
      t.integer :data_type_id
      t.text :value
      t.string :unit

      t.timestamps
    end
  end
end
