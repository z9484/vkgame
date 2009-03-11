class Point < ActiveRecord::Base

  belongs_to :map
  belongs_to :terrain
  has_many :characters

  serialize :foes

end
