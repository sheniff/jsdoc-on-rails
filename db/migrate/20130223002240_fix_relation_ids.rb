class FixRelationIds < ActiveRecord::Migration
  def change
    rename_column :jsdoc_section_attributes, :section_id, :jsdoc_section_id
    rename_column :jsdoc_function_attributes, :function_id, :jsdoc_function_id
    rename_column :jsdoc_functions, :section_id, :jsdoc_section_id
  end
end
