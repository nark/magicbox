class AddAttrsToSamples < ActiveRecord::Migration[5.2]
  def change
  	add_column :samples, :html_color, :string
  	add_column :samples, :category_name, :string, default: "default"
  end
end
