class CreateStrains < ActiveRecord::Migration[5.2]
  def change
    create_table :strains do |t|
      t.string :name
      t.string :description
      t.integer :strain_type
      t.integer :crosses
      t.string :breeder
      t.string :effects
      t.string :ailments
      t.string :flavors
      t.string :location
      t.string :terpenes

      t.timestamps
    end
  end
end
