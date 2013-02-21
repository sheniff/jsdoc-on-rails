class Function < ActiveRecord::Base
  belongs_to :section
  attr_accessible :code, :content, :description, :name
end
