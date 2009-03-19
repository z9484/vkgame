class BaseItem < ActiveRecord::Base

  has_many :items

  def create_item(params = {})
    items.create(attributes.slice(*%w(value gold weight)).merge(params))
  end

end
