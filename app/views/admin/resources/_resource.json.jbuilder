json.extract! resource, :id, :name, :shortname, :description, :category_id, :choices, :units, :created_at, :updated_at
json.url resource_url(resource, format: :json)
