class FixColumnsName < ActiveRecord::Migration
  def change
    rename_column :section_attributes, :type, :name
    rename_column :function_attributes, :type, :name
    rename_column :function_attributes, :parameter, :param
  end
end
