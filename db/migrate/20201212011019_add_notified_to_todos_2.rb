class AddNotifiedToTodos2 < ActiveRecord::Migration[5.2]
  def change
  	add_column :todos, :notified_date, :datetime
  	add_column :todos, :renotify_every_minute, :integer, default: 15
  end
end
