class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :alert_id
      t.integer :user_id
      t.boolean :email_sent, default: false
      t.boolean :read, default: false

      t.timestamps
    end
  end
end
