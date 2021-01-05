class AddLastDurationCheckedAtToConditions < ActiveRecord::Migration[5.2]
  def change
  	add_column :conditions, :last_duration_checked_at, :datetime
  end
end
