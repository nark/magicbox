json.extract! room, :id, :name, :room_type, :length, :width, :height, :created_at, :updated_at, :current_temperature, :current_humidity

json.devices room.devices do |device|
	json.extract! device, :id, :device_type, :device_state, :name, :product_reference, :description, :created_at, :updated_at, :pin_number, :pin_type, :last_start_date, :default_duration, :room_id, :use_duration, :watts, :volts, :amperes, :custom_identifier
end

json.subjects room.active_subjects do |subject|
	json.extract! subject, :id, :name, :created_at, :updated_at, :room_id, :grow_id, :birth_type, :mother_id, :strain_id, :strain_name, :strain
end

json.scenarios room.scenarios do |scenario|
	json.extract! scenario, :id, :name, :subject_id, :description, :created_at, :updated_at, :enabled
end

json.events room.events.limit(5) do |event|
	json.extract! event, :id, :event_type, :message, :data, :created_at, :updated_at, :room_id, :device_id
end

json.samples room.samples.limit(5) do |sample|
	json.extract! sample, :id, :product_reference, :data_type_id, :value, :unit, :created_at, :updated_at, :device_id, :html_color, :category_name
end