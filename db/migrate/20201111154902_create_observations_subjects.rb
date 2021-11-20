class CreateObservationsSubjects < ActiveRecord::Migration[5.2]
  def change
    create_table :observations_subjects do |t|
      t.integer :observation_id
      t.integer :subject_id

      t.timestamps
    end
  end
end
