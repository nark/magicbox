class CommandJob < ApplicationJob
  def perform(device_id, command)
    @device = Device.find(device_id)

    Rails.logger.info "CommandJob CommandJob CommandJob"

    if command == "start"
    	@device.start(event_type: :cron, event: true)

    elsif command == "stop"
    	@device.stop(event_type: :cron, event: true)
    end
  end
end
