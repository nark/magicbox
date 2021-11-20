class ResourceData < ApplicationRecord
	belongs_to :resource
	#belongs_to :subject
	belongs_to :observation

	attr_accessor :category_id
end
