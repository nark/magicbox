json.extract! event, :id, :event_type, :message, :data, :created_at, :updated_at
json.url event_url(event, format: :json)
