class CreateAlerts < ActiveRecord::Migration[5.2]
  def change
    create_table :alerts do |t|
      t.integer :alert_type
      t.integer :data_type_id
      t.integer :resource_id
      t.integer :user_id
      t.integer :operator
      t.float :value
      t.text :message

      t.timestamps
    end
  end
end
