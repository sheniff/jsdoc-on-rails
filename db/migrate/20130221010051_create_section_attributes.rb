class CreateSectionAttributes < ActiveRecord::Migration
  def change
    create_table :section_attributes do |t|
      t.string :type
      t.string :description
      t.references :section

      t.timestamps
    end
    add_index :section_attributes, :section_id
  end
end
