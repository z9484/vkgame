# Copyright (C) 2009 Daniel Esplin
# Part of the Virtual Kingdoms the Game project. http://www.virtualkingdoms.net/

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2
# or at your option any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY.

# See the COPYING file for more details.

class Point < ActiveRecord::Base

  belongs_to :map
  belongs_to :terrain
  has_many :characters
  has_many :items, :as => :itemable
  has_many :dojo_actions
  has_many :base_actions, :through => :dojo_actions

  serialize :foes
  serialize :special

  def neighbors(character = nil)
    characters.reject {|c| c.id == character.try(:id)}
  end

end
