# Copyright (C) 2009 Daniel Esplin
# Part of the Virtual Kingdoms the Game project. http://www.virtualkingdoms.net/

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2
# or at your option any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY.

# See the COPYING file for more details.

module ActionsView

  ACTION_IMAGE_KEYS = [
    :quit, :b, :'7', :'8', :'9',
    :c, :d, :'4', :'5', :'6',
    :e, :f, :'1', :'2', :'3',
    :g, :h, :'0', :'.', :'enter',
  ]

  def show_actions(character)
    flow :width => 350 do
      background BASE_LIGHT
      border BASE_MID, :strokewidth => 5
      @action_images = {}
      # background BASE_LIGHT..BASE_MID
      styles = {:width => 60, :height => 60, :margin => 3}
      flow :width => 340, :displace_left => 5 do
        flow :displace_left => 5, :displace_top => 5 do
          ACTION_IMAGE_KEYS.each do |key|
            stack :width => 66, :height => 66, :margin => 3 do
              @action_images[key] = image("images/actions/empty.png", styles)
            end
          end
        end
      end
    end
    update_actions(character)
  end

  def update_actions(character)
    character.available_actions.each do |action|
      key = action_image_key_from_slug(action.slug)
      next if key.nil?
      @action_images[key].path = "images/actions/#{action.slug}.png"
      @action_images[key].click do |image|
        handle character, action_image_key_from_slug(File.basename(image.path, '.png'))
      end
    end
  end

  def action_image_key_from_slug(slug)
    case slug.to_sym
    when :camp
      :quit
    when :south
      :'2'
    when :west
      :'4'
    when :east
      :'6'
    when :north
      :'8'
    else
      puts "Don't know which image to use for #{slug} action."
      nil
    end
  end

end
