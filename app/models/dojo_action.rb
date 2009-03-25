class DojoAction < ActiveRecord::Base
  belongs_to :point
  belongs_to :base_action
end
