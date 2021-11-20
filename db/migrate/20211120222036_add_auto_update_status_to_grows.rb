class AddAutoUpdateStatusToGrows < ActiveRecord::Migration[5.2]
  def change
    add_column :grows, :auto_update_status, :boolean, default: true
  end
end
