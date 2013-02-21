class FunctionAttribute < ActiveRecord::Base
  belongs_to :function
  attr_accessible :name, :param, :description
end
