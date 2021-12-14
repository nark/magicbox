class AddIndexesToHasMany < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!
  
  def change
    add_index :devices, :room_id, :algorithm => :concurrently

    add_index :subjects, :room_id, :algorithm => :concurrently
    add_index :subjects, :grow_id, :algorithm => :concurrently
    add_index :subjects, :mother_id, :algorithm => :concurrently
    add_index :subjects, :strain_id, :algorithm => :concurrently

    add_index :batches, :grow_id, :algorithm => :concurrently
    add_index :batches, :harvest_id, :algorithm => :concurrently

    add_index :condition_groups, :scenario_id, :algorithm => :concurrently
    add_index :conditions, :condition_group_id, :algorithm => :concurrently

    add_index :devices_data_types, :device_id, :algorithm => :concurrently
    add_index :devices_data_types, :data_type_id, :algorithm => :concurrently

    add_index :events, :user_id, :algorithm => :concurrently

    add_index :issues, :resource_id, :algorithm => :concurrently
    add_index :issues, :subject_id, :algorithm => :concurrently
    add_index :issues, :observation_id, :algorithm => :concurrently

    add_index :notifications, :user_id, :algorithm => :concurrently

    add_index :observations, :user_id, :algorithm => :concurrently
    add_index :observations, :subject_id, :algorithm => :concurrently
    add_index :observations, :grow_id, :algorithm => :concurrently
    add_index :observations, :room_id, :algorithm => :concurrently

    add_index :observations_subjects, :observation_id, :algorithm => :concurrently
    add_index :observations_subjects, :subject_id, :algorithm => :concurrently

    add_index :push_devices, :device_id, :algorithm => :concurrently
    add_index :push_devices, :user_id, :algorithm => :concurrently

    add_index :resource_datas, :resource_id, :algorithm => :concurrently
    add_index :resource_datas, :observation_id, :algorithm => :concurrently
    add_index :resource_datas, :subject_id, :algorithm => :concurrently

    add_index :todos, :user_id, :algorithm => :concurrently

    add_index :weeks, :grow_id, :algorithm => :concurrently
  end
end
