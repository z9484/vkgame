# Copyright (C) 2009 Daniel Esplin
# Part of the Virtual Kingdoms the Game project. http://www.virtualkingdoms.net/

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2
# or at your option any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY.

# See the COPYING file for more details.

class Army < ActiveRecord::Base

  belongs_to :character
  belongs_to :point

  before_create :set_defaults

  def set_defaults
    self.point_id = Point.find_by_i(2971)
    self.character_id = character.name
    self.footmen = 0
    self.archers = 0
    self.pikemen = 0
    self.knights = 0
    self.healers = 0
    self.catapults = 0   
  end

end
