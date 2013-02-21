class FunctionAttribute < ActiveRecord::Base
  belongs_to :function
  attr_accessible :description, :parameter, :type
end
