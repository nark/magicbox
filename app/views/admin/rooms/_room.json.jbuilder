json.extract! room, :id, :name, :room_type, :length, :width, :height, :created_at, :updated_at
json.url room_url(room, format: :json)
