class Prize < ActiveRecord::Base
  belongs_to :foe
  belongs_to :base_item
end
