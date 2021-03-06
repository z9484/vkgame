# Copyright (C) 2009 Daniel Esplin
# Part of the Virtual Kingdoms the Game project. http://www.virtualkingdoms.net/

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2
# or at your option any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY.

# See the COPYING file for more details.

class Action < ActiveRecord::Base
  belongs_to :base_action
  belongs_to :character

  def slug
    base_action.slug
  end

  def available?
    case slug.to_sym
    when :enter
      character.point.terrain.enterable?
    else
      true
    end
  end

end
