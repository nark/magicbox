class CreateTodos < ActiveRecord::Migration[5.2]
  def change
    create_table :todos do |t|
      t.integer :todo_status, default: 0
      t.integer :user_id
      t.datetime :date
      t.text :body
      t.boolean :notify, default: true

      t.timestamps
    end
  end
end
