# Copyright (C) 2009 Daniel Esplin
# Part of the Virtual Kingdoms the Game project. http://www.virtualkingdoms.net/

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2
# or at your option any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY.

# See the COPYING file for more details.

module FieldView

  def show_field(character)
    background BASE_LIGHT
    flow character.field_flow_options do
      @field_images = {:terrains => [], :neighbors => [], :items => [], :army => []}
      character.field_points.each do |p|
        stack :width => 68, :height => 68 do
          if character.point == p
            background COMPLEMENT1_LIGHTER#, :strokewidth => 5
          else
            background COMPLEMENT2_LIGHTER
          end
          @field_images[:terrains] << image("images/terrains/void.png", :width => 60, :height => 60, :margin => [2, 2, 0, 0], :displace_left => 3, :displace_top => 3)
          @field_images[:neighbors] << image("images/terrains/overlays/empty.png", :width => 60, :height => 60, :margin => [2, 2, 0, 0], :displace_left => 3, :displace_top => -60 + 3)
          @field_images[:items] << image("images/terrains/overlays/empty.png", :width => 60, :height => 60, :margin => [2, 2, 0, 0], :displace_left => 3, :displace_top => -60 * 2 + 3)
          @field_images[:army] << image("images/terrains/overlays/empty.png", :width => 60, :height => 60, :margin => [2, 2, 0, 0], :displace_left => 3, :displace_top => -60 * 3 + 3)
        end
      end
    end
    update_images(character)
  end

  def update_images(character)
    character.field_points.zip(@field_images[:terrains], @field_images[:neighbors], @field_images[:items], @field_images[:army]) do |p, t, n, i, a|
      if p.terrain.try(:slug).nil?
        puts "Error finding terrain for point #{p.id}"
        t.path = "images/terrains/void.png"
      else
        t.path = "images/terrains/#{p.terrain.try(:slug)}.png"
      end
      if p.neighbors(character).empty?
        n.path = "images/terrains/overlays/empty.png"
      else
        n.path = "images/terrains/overlays/camp.png"
      end
      if p.items.empty?
        i.path = "images/terrains/overlays/empty.png"
      else
        i.path = "images/terrains/overlays/items.png"
      end
      if p.army
        a.path = "images/terrains/overlays/army.png"
      else
        a.path = "images/terrains/overlays/empty.png"
      end
    end
  end

end
