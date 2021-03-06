# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130223002240) do

  create_table "jsdoc_function_attributes", :force => true do |t|
    t.string   "name"
    t.string   "param"
    t.string   "description"
    t.integer  "jsdoc_function_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "jsdoc_function_attributes", ["jsdoc_function_id"], :name => "index_function_attributes_on_function_id"

  create_table "jsdoc_functions", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "content"
    t.text     "code"
    t.integer  "jsdoc_section_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "jsdoc_functions", ["jsdoc_section_id"], :name => "index_functions_on_section_id"

  create_table "jsdoc_section_attributes", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "jsdoc_section_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "jsdoc_section_attributes", ["jsdoc_section_id"], :name => "index_section_attributes_on_section_id"

  create_table "jsdoc_sections", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

end
