json.extract! alert, :id, :alert_type, :data_type_id, :resource_id, :user_id, :operator, :value, :message, :created_at, :updated_at
json.url alert_url(alert, format: :json)
