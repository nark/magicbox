class Scenario < ApplicationRecord
	has_many :room_scenarios
	has_many :rooms, through: :room_scenarios

	#belongs_to :subject

	has_many :crons
	has_many :conditions
	has_many :operations

	accepts_nested_attributes_for :crons, allow_destroy: true, reject_if: :all_blank
	accepts_nested_attributes_for :conditions, allow_destroy: true, reject_if: :all_blank

	def self.run
		logger.info "\n########################\n"
		logger.info "\n# Run scenarios\n"

		Room.all.each do |room|
			scenario = room.scenario

			logger.info "\n -> #{room.name} : #{scenario.name} [#{scenario.crons.count} crons]\n"

			scenario.crons.each do |cron|
				logger.info "\ncron #{cron}\n"

				now = Time.now

				sleep 1

				every_time_ok = false
				seconds_max = 0

				#logger.info  \n"command : #{cron.command}\n"
				check_between = cron.need_check_between()
				between = cron.cron_between_is_valid(now)

				if check_between and !between
					logger.info "\n#{cron.device.name} between is not valid: Abort\n"
					next
				end


				if cron.any_time? and !check_between
					logger.info "\n#{cron.device.name} is any time and not need between: Execute\n"
					cron.execute_command()
					next
				end

				if cron.any_time? and check_between and !between
					logger.info "\n#{cron.device.name} is any time and between is not valid: Abort\n"
					next
				end

				if !cron.time_value
					logger.info "\n#{cron.device.name} time value is not valid #{cron.time_value}: Abort\n"
					next
				end

				if cron.time_value == 0 and !check_between
					logger.info "\n#{cron.device.name} is every time and not need between: Execute\n"
					cron.execute_command()
					next
				end

				if cron.time_value == 0 and check_between and !between
					logger.info "\n#{cron.device.name} is every time and between is not valid: Abort\n"
					next
				end

				if cron.time_value == 0 and check_between and between
					logger.info "\n#{cron.device.name} is every time and between is valid: Execute\n"
					cron.execute_command()
					next
				end

				if !cron.last_exec_time
					logger.info "\n#{cron.device.name} was never executed: Execute\n"
					cron.execute_command()
					next
				end				

				valid_period = cron.has_valid_period(now)

				logger.info valid_period

				if valid_period
					logger.info "\n#{cron.device.name} has a valid period: Execute\n"
					cron.execute_command()
					next
				end

				logger.info "\n#{cron.device.name} end of condition: Abort\n"
				next
			end
		end

		logger.info "\n########################\n"
	end
end
