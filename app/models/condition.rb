class Condition < ApplicationRecord
	belongs_to :scenario
	has_many :operations 

	accepts_nested_attributes_for :operations, allow_destroy: true, reject_if: :all_blank
end
