class CommandJob < ApplicationJob
  def perform(device_id, command, event_type = :cron)
    @device = Device.find(device_id)

    if command == "start"
    	@device.start(event_type: event_type, event: true)

    elsif command == "stop"
    	@device.stop(event_type: event_type, event: true)
    end

    sleep 1
  end
end
