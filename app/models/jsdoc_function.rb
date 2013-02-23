class JsdocFunction < ActiveRecord::Base
  attr_accessible :code, :content, :description, :name
  belongs_to :jsdoc_section
  has_many :jsdoc_function_attributes, :dependent => :destroy
end
