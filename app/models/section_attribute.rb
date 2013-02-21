class SectionAttribute < ActiveRecord::Base
  belongs_to :section
  attr_accessible :description, :type
end
