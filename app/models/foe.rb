class Foe < ActiveRecord::Base
  has_many :prizes
  has_many :base_items, :through => :prizes
end
