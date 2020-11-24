class CreateIssues < ActiveRecord::Migration[5.2]
  def change
    create_table :issues do |t|
      t.integer :resource_id
      t.integer :subject_id
      t.integer :observation_id
      t.integer :severity
      t.integer :issue_type
      t.integer :issue_status

      t.timestamps
    end
  end
end
