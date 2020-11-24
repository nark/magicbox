class CreateSettings < ActiveRecord::Migration[5.2]
  def self.up
    create_table :settings do |t|
      t.string  :var,        null: false
      t.text    :value,      null: true
      t.timestamps
    end

    add_index :settings, %i(var), unique: true
  end

  def self.down
    drop_table :settings
  end
end
