# Copyright (C) 2009 Daniel Esplin
# Part of the Virtual Kingdoms the Game project. http://www.virtualkingdoms.net/

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2
# or at your option any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY.

# See the COPYING file for more details.

module VKView

  ACTION_IMAGE_KEYS = [
    :quit, :b, :'7', :'8', :'9',
    :c, :d, :'4', :'5', :'6',
    :e, :f, :'1', :'2', :'3',
    103, 104, :'0', :'.', :'enter',
  ]

=begin
  ACTION_IMAGE_KEYS = [
    98, 
    99, 
    101, 102, 
    103, 104, 46, 65293, 65421,   
  ]

  def show_actions(character)
    @action_images = {}
    ACTION_IMAGE_KEYS.each do |key|
        @action_images[key] = image("images/actions/empty.png", styles)
    end
    update_actions(character)
  end

=end
  def update_actions(character)
  end
=begin
    # @action_images.each do |key, image|
    #   if action.available?
    #     image.path = "images/actions/#{action.slug}.png"
    #     image.click do |i|
    #       handle character, action_image_key_from_slug(File.basename(i.path, '.png'))
    #     end
    #   else
    #     image.path = "images/actions/empty.png"
    #   end
    # end
    for @action_images.each_value do |image|
      image.path = "images/actions/empty.png"
    end
    character.reload.actions.select {|a| a.available?}.each do |action|
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
    when :enter
      :enter
    else
      # puts "Don't know which image to use for #{slug} action."
      nil
    end
  end
=end
end
