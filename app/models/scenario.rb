class Scenario < ApplicationRecord
	has_many :room_scenarios, dependent: :destroy
	has_many :rooms, through: :room_scenarios

	#belongs_to :subject

	has_many :condition_groups, dependent: :destroy
	has_many :conditions, through: :condition_groups
	has_many :operations, through: :condition_groups

	accepts_nested_attributes_for :condition_groups, allow_destroy: true, reject_if: :all_blank



	def run2(room)
		if self.enabled
			self.condition_groups.where(enabled: true).each do |condition_group|
				logger.info "\nCondition group #{condition_group.name} check...\n"

				conditions_matched = condition_group.conditions.empty?

				condition_group.conditions.each do |condition|
					logger.info "\nChecking conditions...\n"

					conditions_matched = condition.check_condition(room)

					break unless conditions_matched
				end 

				if conditions_matched
					logger.info "\nAll conditions matched, executing operations...\n"
					condition_group.operations.each do |operation|
						sleep 2
						operation.execute_operation()
					end
				else
					logger.info "\nNo condition matched\n"
				end

			end
		else
			logger.info "\nScenario #{self.name} skipped: disabled \n"
		end
	end



	def self.run2
		logger.info "\n########################\n"
		logger.info "\n#  Run scenarios (v2)  #\n"

		Room.all.each do |room|
			scenario = room.scenario

			logger.info "\n -> #{room.name} : #{scenario.name} [#{scenario.conditions.count} conditions]\n"

			scenario.run2(room)
		end

		logger.info "\n########################\n"
	end
end
