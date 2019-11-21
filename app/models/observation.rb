class Observation < ApplicationRecord
	belongs_to :user
	belongs_to :grow
	belongs_to :subject, optional: true
	belongs_to :room, optional: true
end
