class BaseAction < ActiveRecord::Base
  has_many :actions
  has_many :base_action_items
  has_many :base_items, :through => :base_action_items
  has_many :dojo_actions
end
