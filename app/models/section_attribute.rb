class SectionAttribute < ActiveRecord::Base
  belongs_to :section
  attr_accessible :name, :description
end
