class ConditionGroup < ApplicationRecord
	belongs_to :scenario
	
	has_many :conditions, dependent: :destroy
	has_many :operations, dependent: :destroy

	validates :name, presence: true

	accepts_nested_attributes_for :conditions, allow_destroy: true, reject_if: :all_blank
	accepts_nested_attributes_for :operations, allow_destroy: true, reject_if: :all_blank

	def as_json(*args)
	  super.tap { |hash| 
	  	hash["conditions_attributes"] = hash.delete "conditions"
	  	hash["operations_attributes"] = hash.delete "operations"  
	  }
	end
end
