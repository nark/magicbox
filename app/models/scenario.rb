require 'mb_logger'

class Scenario < ApplicationRecord
	attr_accessor :json_file

	has_many :room_scenarios, dependent: :destroy
	has_many :rooms, through: :room_scenarios

	validates :name, presence: true

	has_many :condition_groups, dependent: :destroy#, key: "condition_groups_attributes"
	has_many :conditions, through: :condition_groups
	has_many :operations, through: :condition_groups

	accepts_nested_attributes_for :condition_groups, allow_destroy: true, reject_if: :all_blank

	def as_json(*args)
	  super.tap { |hash| 
	  	hash['condition_groups'].each do |groups|
	  		groups.tap { |h| 
			    h['conditions_attributes'] = h.delete('conditions')
			    h['operations_attributes'] = h.delete('operations')
			  }
			end
	  	hash["condition_groups_attributes"] = hash.delete "condition_groups" 
	  }
	end


	def run2(room)
		if self.enabled
			self.condition_groups.where(enabled: true).each do |condition_group|
				MB_LOGGER.tagged("Scenario-#{self.id}") do
					MB_LOGGER.info "Condition group #{condition_group.name} checking..."
				end 

				conditions_matched = condition_group.conditions.empty?

				condition_group.conditions.each do |condition|
					MB_LOGGER.tagged("Scenario-#{self.id}") do
						MB_LOGGER.info "* Checking conditions..."
					end

					conditions_matched = condition.check_condition(room)

					break unless conditions_matched
				end 

				if conditions_matched
					MB_LOGGER.tagged("Scenario-#{self.id}") do
						MB_LOGGER.info "* All conditions matched, executing operations..."
					end
					condition_group.operations.each do |operation|
						sleep 2
						operation.execute_operation(room)
					end
				else
					MB_LOGGER.tagged("Scenario-#{self.id}") do
						MB_LOGGER.info "* No condition matched"
					end
				end

			end
		else
			MB_LOGGER.info "Scenario #{self.name} skipped: disabled "
		end
	end



	def self.run2
		MB_LOGGER.info "########################"
		MB_LOGGER.info "#  Run scenarios (v2)  #"

		Room.all.each do |room|
			room.scenarios.where(enabled: true).each do |scenario|
				MB_LOGGER.tagged("Scenario-#{scenario.id}") do
					MB_LOGGER.info "-> #{room.name} : #{scenario.name} [#{scenario.conditions.count} conditions]"
				end
				
				scenario.run2(room)
			end
		end

		MB_LOGGER.info "########################"
	end


	def self.import(file_path, name)
		json_data = File.read(file_path)
    json = JSON.parse(json_data)

    scenario = Scenario.new(json)
    scenario.name = name

    scenario.save!
    return scenario
	end
end
