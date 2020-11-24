class SwitchToUuids < ActiveRecord::Migration[5.2]
  def change
  	enable_extension 'pgcrypto'

  	add_column :todos, :uuid, :uuid, null: false, default: -> { "gen_random_uuid()" }

  	change_table :todos do |t|
      t.remove :id
      t.rename :uuid, :id
    end
    execute "ALTER TABLE todos ADD PRIMARY KEY (id);"


    add_column :weeks, :uuid, :uuid, null: false, default: -> { "gen_random_uuid()" }

  	change_table :weeks do |t|
      t.remove :id
      t.rename :uuid, :id
    end
    execute "ALTER TABLE weeks ADD PRIMARY KEY (id);"
  end
end
