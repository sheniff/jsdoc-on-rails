class Section < ActiveRecord::Base
  attr_accessible :name, :description
  has_many :functions, :dependent => :destroy
  has_many :section_attributes, :dependent => :destroy
end
