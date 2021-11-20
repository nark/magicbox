class CreateHarvests < ActiveRecord::Migration[5.2]
  def change
    create_table :harvests do |t|
      t.references :grow
      t.float :harvested_trim_weight, default: 0.0
      t.float :harvested_waste_weight, default: 0.0
      t.float :harvested_bud_weight, default: 0.0
      t.float :dry_trim_weight, default: 0.0
      t.float :dry_bud_weight, default: 0.0

      t.timestamps
    end
  end
end
