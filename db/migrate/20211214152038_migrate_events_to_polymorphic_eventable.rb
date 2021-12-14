class MigrateEventsToPolymorphicEventable < ActiveRecord::Migration[5.2]
  def change
    Event.all.each do |e|
      if e.device
        e.eventable_type = "Device"
        e.eventable_id = e.device_id
        e.save!
      elsif e.room
        e.eventable_type = "Room"
        e.eventable_id = e.room_id
        e.save!
      end
    end
  end
end
