class AddEventForExistingObservations < ActiveRecord::Migration[5.2]
  def change
    Observation.all.each do |o|
      Event.create!(
        event_type: :action, 
        message: "New observation has been created by <b>#{o.user.username}</b>", 
        eventable: o, 
        created_at: o.created_at, 
        updated_at: o.updated_at)
    end
  end
end
