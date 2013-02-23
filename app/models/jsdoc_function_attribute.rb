class JsdocFunctionAttribute < ActiveRecord::Base
  belongs_to :jsdoc_function
  attr_accessible :name, :param, :description
end
