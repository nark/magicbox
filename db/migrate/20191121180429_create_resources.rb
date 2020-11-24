class CreateResources < ActiveRecord::Migration[5.2]
  def change
    create_table :resources do |t|
      t.string :name
      t.string :shortname
      t.text :description
      t.integer :category_id
      t.string :choices, array: true, default: []
      t.string :units, array: true, default: []

      t.timestamps
    end
  end
end
