class SwitchNotifiableToUuid < ActiveRecord::Migration[5.2]
  def change
  	enable_extension 'pgcrypto'

  	add_column :notifications, :notifiable_uuid, :uuid, null: true

  	change_table :notifications do |t|
      t.remove :notifiable_id
      t.rename :notifiable_uuid, :notifiable_id
    end
  end
end
