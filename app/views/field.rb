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
    stack :width => 350, :height => 350 do
      background BASE_MID
      flow :width => 340, :height => 340, :displace_left => 5, :displace_top => 5 do
        background COMPLEMENT2_LIGHTER
        border BASE_LIGHT, :strokewidth => 5
        nostroke
        fill COMPLEMENT1_MID
        rect :width => 65, :height => 65, :top => 137, :left => 137
        flow :displace_left => 5, :displace_top => 5 do
          @field_images = {:terrains => [], :neighbors => [], :items => [], :army => []}
          character.field_points.each_with_index do |p, i|
            styles = {:width => 60, :height => 60}
            stack :width => 66, :height => 66, :margin => 3 do
              @field_images[:terrains] << image("images/terrains/void.png", styles) {handle(character, :look, i)}
              @field_images[:neighbors] << image("images/terrains/overlays/empty.png", styles.merge(:displace_top => -60))
              @field_images[:items] << image("images/terrains/overlays/empty.png", styles.merge(:displace_top => -60 * 2))
              @field_images[:army] << image("images/terrains/overlays/empty.png", styles.merge(:displace_top => -60 * 3))
            end
          end
        end
      end
      update_images(character)
    end
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
