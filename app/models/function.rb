class Function < ActiveRecord::Base
  attr_accessible :code, :content, :description, :name
  belongs_to :section
  has_many :function_attributes, :dependent => :destroy
end
