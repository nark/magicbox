class CreateAlertPushUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :alert_push_users do |t|
      t.integer :user_id
      t.integer :alert_id

      t.timestamps
    end
  end
end
