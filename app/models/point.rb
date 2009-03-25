class Point < ActiveRecord::Base

  belongs_to :map
  belongs_to :terrain
  has_many :characters
  has_many :items, :as => :itemable
  has_many :dojo_actions
  has_many :base_actions, :through => :dojo_actions

  serialize :foes
  serialize :special

end
