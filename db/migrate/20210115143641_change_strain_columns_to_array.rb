class ChangeStrainColumnsToArray < ActiveRecord::Migration[5.2]
  def up
    change_column :strains, :effects, :text, array: true, default: [], using: "(string_to_array(effects, ','))"
    change_column :strains, :ailments, :text, array: true, default: [], using: "(string_to_array(ailments, ','))"
    change_column :strains, :flavors, :text, array: true, default: [], using: "(string_to_array(flavors, ','))"

  end

  def down
    change_column :strains, :effects, :text, array: false, default: nil, using: "(array_to_string(effects, ','))"
    change_column :strains, :ailments, :text, array: false, default: nil, using: "(array_to_string(ailments, ','))"
    change_column :strains, :flavors, :text, array: false, default: nil, using: "(array_to_string(flavors, ','))"
  end
end
