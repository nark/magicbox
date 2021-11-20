json.extract! grow, :id, :description, :start_date, :end_date, :substrate, :flowering, :created_at, :updated_at, :grow_status, :number_of_subjects, :seedling_weeks, :vegging_weeks, :flowering_weeks, :flushing_weeks, :drying_weeks, :curing_weeks, :birth_type, :mother_id, :estimated_weight_by_square_meter, :progress_percents

json.subjects grow.active_subjects do |subject|
	json.extract! subject, :id, :name, :created_at, :updated_at, :room_id, :grow_id, :birth_type, :mother_id, :strain_id, :strain_name, :strain
end

json.weeks grow.weeks do |week|
	json.extract! week, :id, :week_number, :week_type, :start_date, :end_date, :color
end

json.observations grow.observations do |observation|
	json.extract! observation, :id, :user_id, :grow_id, :subject_id, :body, :water, :nutrients, :created_at, :updated_at, :room_id, :text, :start_date, :end_date, :pictures_url
end
