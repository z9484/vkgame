# Copyright (C) 2009 Daniel Esplin
# Part of the Virtual Kingdoms the Game project. http://www.virtualkingdoms.net/

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2
# or at your option any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY.

# See the COPYING file for more details.

class BaseAction < ActiveRecord::Base
  has_many :actions
  has_many :base_action_items
  has_many :base_items, :through => :base_action_items
  has_many :dojo_actions
end
