class JsdocSection < ActiveRecord::Base
  attr_accessible :name, :description
  has_many :jsdoc_functions, :dependent => :destroy
  has_many :jsdoc_section_attributes, :dependent => :destroy
end
