json.extract! observation, :id, :user_id, :grow_id, :room_id, :subject_id, :body, :water, :nutrients, :created_at, :updated_at
json.url observation_url(observation, format: :json)
