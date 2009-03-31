# Copyright (C) 2009 Daniel Esplin
# Part of the Virtual Kingdoms the Game project. http://www.virtualkingdoms.net/

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2
# or at your option any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY.

# See the COPYING file for more details.

module InventoryView

  def show_inventory(character)
    flow :margin => [3, 3, 0, 0] do
      character.items.each do |item|
        stack :width => 85, :height => 60, :margin => [3, 3, 0, 0] do
          background COMPLEMENT2_MID..COMPLEMENT2_DARK
          border BASE_MID
          image "images/items/#{item.kind}/#{item.slug}.png"
        end
      end
    end
  end

end
