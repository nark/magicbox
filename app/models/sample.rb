class Sample < ApplicationRecord
	default_scope { order(created_at: :desc) }
	
	belongs_to :data_type
end
