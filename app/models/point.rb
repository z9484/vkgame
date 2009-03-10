class Point < ActiveRecord::Base
  belongs_to :map
  belongs_to :terrain
  serialize :foes
end
