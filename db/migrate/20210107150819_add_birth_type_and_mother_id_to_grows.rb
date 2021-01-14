class AddBirthTypeAndMotherIdToGrows < ActiveRecord::Migration[5.2]
  def change
  	add_column :grows, :birth_type, :integer, default: 0
  	add_column :grows, :mother_id, :integer
  end
end
