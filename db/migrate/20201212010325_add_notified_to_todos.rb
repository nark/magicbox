class AddNotifiedToTodos < ActiveRecord::Migration[5.2]
  def change
  	rename_column :todos, :notify, :notify_email
  	add_column :todos, :notify_push, :boolean, default: true
  end
end
