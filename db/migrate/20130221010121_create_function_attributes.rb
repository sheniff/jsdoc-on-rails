class CreateFunctionAttributes < ActiveRecord::Migration
  def change
    create_table :function_attributes do |t|
      t.string :type
      t.string :parameter
      t.string :description
      t.references :function

      t.timestamps
    end
    add_index :function_attributes, :function_id
  end
end
