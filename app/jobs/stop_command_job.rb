class StopCommandJob < ApplicationJob
  def perform(device_id, event_type)
    @device = Device.find(device_id)
    @device.stop(event_type: event_type, event: true)
  end
end
