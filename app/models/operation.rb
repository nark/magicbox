class Operation < ApplicationRecord
	belongs_to :condition
	belongs_to :device

	def execute_operation
		if command == "start"
      logger.info "\n  -> Start #{device.name}\n"
      
      device.start(event_type: :condition, event: false)

      logger.info "#{duration} #{duration.class}"

      if duration and duration != 0
        logger.info "\n   -> #{device.name} will stop in #{duration} sec.\n"
        CommandJob.perform_in(duration.seconds, device.id, "stop")
      end
      
      return
    end


    if command == "stop"
      logger.info "\n  -> Stop #{device.name}\n"
      
      device.stop(event_type: :condition, event: false)

      if duration and duration != 0
        logger.info "\n   -> #{device.name} will start in #{duration} sec.\n"
        CommandJob.perform_in(duration.seconds, device.id, "start")
      end

      return
    end
	end
end
