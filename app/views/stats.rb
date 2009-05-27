# Copyright (C) 2009 Daniel Esplin
# Part of the Virtual Kingdoms the Game project. http://www.virtualkingdoms.net/

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2
# or at your option any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY.

# See the COPYING file for more details.

module StatsView

  def show_stats(character)
    stack :width => 250 do
      background COMPLEMENT2_LIGHT..COMPLEMENT2_MID
      border BASE_MID, :strokewidth => 5
      flow :margin => 5 do
        @stats = para
      end
    end
    update_stats(character)
  end

  def update_stats(character)
    @stats.text = character.stats
  end

end
