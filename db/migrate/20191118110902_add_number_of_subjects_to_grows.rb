class AddNumberOfSubjectsToGrows < ActiveRecord::Migration[5.2]
  def change
  	add_column :grows, :number_of_subjects, :integer, default: 4
  end
end
