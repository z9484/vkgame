# Copyright (C) 2009 Daniel Esplin
# Part of the Virtual Kingdoms the Game project. http://www.virtualkingdoms.net/

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2
# or at your option any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY.

# See the COPYING file for more details.

module InventoryView
=begin
  def show_inventory(character)
    #stack :width => 250, :height => 350, :scroll => true do
    #  background COMPLEMENT2_LIGHT..COMPLEMENT2_MID
    #  border BASE_MID, :strokewidth => 5
    #  @inventory = flow :margin => 5
    end
    update_inventory(character)
  end

  def update_inventory(character)
    @inventory.clear do
      if character.items.empty?
        puts "inventory" #para "This is your inventory. When you pick something up, it will appear here."
      else
        character.items.each do |item|
          puts "inventory" #image "images/items/#{item.kind}/#{item.slug}.png"
        end
      end
    end
  end
=end
end
