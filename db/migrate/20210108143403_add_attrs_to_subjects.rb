class AddAttrsToSubjects < ActiveRecord::Migration[5.2]
  def change
  	add_column :subjects, :birth_type, :integer, default: 0
  	add_column :subjects, :mother_id, :integer
  	add_column :subjects, :strain_id, :integer
  end
end
