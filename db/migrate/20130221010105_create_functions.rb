class CreateFunctions < ActiveRecord::Migration
  def change
    create_table :functions do |t|
      t.string :name
      t.text :description
      t.text :content
      t.text :code
      t.references :section

      t.timestamps
    end
    add_index :functions, :section_id
  end
end
