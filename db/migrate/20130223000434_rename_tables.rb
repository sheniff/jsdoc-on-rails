class RenameTables < ActiveRecord::Migration
  def up
    rename_table :functions, :jsdoc_functions
    rename_table :sections, :jsdoc_sections
    rename_table :function_attributes, :jsdoc_function_attributes
    rename_table :section_attributes, :jsdoc_section_attributes
  end

  def down
    rename_table :jsdoc_functions, :functions
    rename_table :jsdoc_sections, :sections
    rename_table :jsdoc_function_attributes, :function_attributes
    rename_table :jsdoc_section_attributes, :section_attributes
  end
end
