class Room < ApplicationRecord
	attr_accessor :scenario_id

	has_many :subjects
	has_many :devices, dependent: :delete_all
	has_many :events, dependent: :delete_all
	
	has_one :room_scenario
	has_one :scenario, through: :room_scenario

	enum room_type: {
		box: 				0,
		closet: 		1,
		room: 			2,
		greenhouse: 3
	}
end
