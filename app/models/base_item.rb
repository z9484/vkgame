class BaseItem < ActiveRecord::Base

  has_many :prizes
  has_many :items
  has_many :foes, :through => :prizes
  has_many :base_action_items
  has_many :base_actions, :through => :base_action_items

  def create_item(params = {})
    items.create(attributes.slice(*%w(value gold weight)).merge(params))
  end

end
