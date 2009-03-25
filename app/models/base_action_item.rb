class BaseActionItem < ActiveRecord::Base
  belongs_to :base_item
  belongs_to :base_action
end
