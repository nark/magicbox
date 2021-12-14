class AddAttrsToEvents < ActiveRecord::Migration[5.2]
  def change
    add_reference :events, :eventable, polymorphic: true, index: true
  end
end
