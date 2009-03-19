class Item < ActiveRecord::Base

  belongs_to :base_item
  belongs_to :itemable, :polymorphic => true

  def name; base_item.name; end
  def slug; base_item.slug; end
  def kind; base_item.kind; end

end
