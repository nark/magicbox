class SwitchAlertToUuid < ActiveRecord::Migration[5.2]
  def change
  	enable_extension 'pgcrypto'

  	add_column :alerts, :uuid, :uuid, null: false, default: -> { "gen_random_uuid()" }

  	change_table :alerts do |t|
      t.remove :id
      t.rename :uuid, :id
    end

    execute "ALTER TABLE alerts ADD PRIMARY KEY (id);"

    add_column :alert_users, :alert_uuid, :uuid, null: false, default: -> { "gen_random_uuid()" }

  	change_table :alert_users do |t|
      t.remove :alert_id
      t.rename :alert_uuid, :alert_id
    end
  end
end
