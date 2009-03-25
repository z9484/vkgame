class Action < ActiveRecord::Base
  belongs_to :base_action
  belongs_to :character
end
