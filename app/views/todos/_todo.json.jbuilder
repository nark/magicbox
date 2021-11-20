json.extract! todo, :id, :todo_status, :user_id, :date, :body, :notify, :created_at, :updated_at
json.url todo_url(todo, format: :json)
