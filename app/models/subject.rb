class Subject < ApplicationRecord
	has_many :scenarios
	belongs_to :room
end
