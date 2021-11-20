class CreateScenarios < ActiveRecord::Migration[5.2]
  def change
    create_table :scenarios do |t|
      t.string :name
      t.integer :subject_id
      t.string :description

      t.timestamps
    end
  end
end
