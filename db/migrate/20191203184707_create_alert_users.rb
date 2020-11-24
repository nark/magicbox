class CreateAlertUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :alert_users do |t|
      t.integer :alert_id
      t.integer :user_id

      t.timestamps
    end
  end
end
