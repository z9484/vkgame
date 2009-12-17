# Copyright (C) 2009 Daniel Esplin
# Part of the Virtual Kingdoms the Game project. http://www.virtualkingdoms.net/

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2
# or at your option any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY.

# See the COPYING file for more details.

module FoeView
  def fight(character, foe)
    puts "enemy encountered"
  end
=begin
  BORDER_WIDTH = 2
  TOP_HEIGHT = 200
  def fight(character, foe)
    window :width => 250, :height => 400 do
      @character, @foe = character, foe
      @foe_vitality = @foe.hp
      def attack
        @statusline.text = "you attack"
        @character.hp -= rand(3)
        @cbar.height = (@character.vitality - @character.hp).to_f / @character.vitality * TOP_HEIGHT
        @foe.hp -= rand(5)
        @fbar.height = (@foe_vitality - @foe.hp).to_f / @foe_vitality * TOP_HEIGHT
        if @foe.hp < 0
          alert 'you win!'
          close
        elsif @character.hp < 0
          alert 'You lose!'
          close
        end
      end
      def run
        if rand(4).zero?
          alert "You get away"
          close
        else
          @statusline.text = "you can't escape"
        end
      end
      stack do
        width = 10
        height = TOP_HEIGHT - BORDER_WIDTH * 2
        top = BORDER_WIDTH
        left = 250 - BORDER_WIDTH * 3 - width

        image("images/foes/croc.png", :displace_left => 25)

        stroke black
        hph = (@character.vitality - @character.hp).to_f / @character.vitality * TOP_HEIGHT
        fill green
        rect :width => width, :height => height, :top => top
        fill red
        @cbar = rect :width => width, :height => hph, :top => top

        stroke black
        fill green
        rect :width => width, :height => TOP_HEIGHT, :left => left
        fill red
        @fbar = rect :width => width, :height => (@foe_vitality - @foe.hp).to_f / @foe_vitality * TOP_HEIGHT, :left => left

        @statusline = para "You encounter a croc"
        flow do
          image("images/actions/attack.png") do
            attack
          end
          image("images/actions/run.png") do
            run
          end
        end
      end
      keypress do |k|
        case k
        when 'a'
          attack
        when 'r'
          run
        end
      end
    end
  end
=end
end
