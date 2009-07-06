# Copyright (C) 2009 Daniel Esplin
# Part of the Virtual Kingdoms the Game project. http://www.virtualkingdoms.net/

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2
# or at your option any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY.

# See the COPYING file for more details.

class Fort < ActiveRecord::Base

  belongs_to :character
  belongs_to :point

  before_create :set_defaults

  private

  def set_defaults
    self.point = Map.find_by_name('Small').points.find_by_i(1076)
    true
  end

end
