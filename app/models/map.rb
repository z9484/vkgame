class Map < ActiveRecord::Base
  has_many :points
  has_many :characters
end
