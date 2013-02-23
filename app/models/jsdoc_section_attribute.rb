class JsdocSectionAttribute < ActiveRecord::Base
  belongs_to :jsdoc_section
  attr_accessible :name, :description
end
