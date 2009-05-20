# Copyright (C) 2009 Daniel Esplin
# Part of the Virtual Kingdoms the Game project. http://www.virtualkingdoms.net/

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2
# or at your option any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY.

# See the COPYING file for more details.

class Character < ActiveRecord::Base

  belongs_to :race
  belongs_to :point
  has_many :items, :as => :itemable
  has_many :actions

  before_create :set_defaults

  def after_initialize
    @refreshables = {}
  end

  def wideview?
    has?(:telescope)
  end

  def field_flow_options
    w, l, t = (wideview? ? [340, 4, 4] : [220, 70, 70])
    {:width => w, :displace_left => l, :displace_top => t}
  end

  def field_points
    w = point.map.width
    i = point.i
    rows = wideview? ? [i - w * 2, i - w, i, i + w, i + w * 2] : [i - w, i, i + w]
    is = rows.map do |r|
      if wideview?
        [r - 2, r - 1, r, r + 1, r + 2]
      else
        [r - 1, r, r + 1]
      end
    end.flatten
    Point.find(:all, :conditions => {:i => is}, :order => 'i')
  end

  def center
    field_points[field_points.size / 2]
  end
  def do(k)
    case k
    when :up, :right, :down, :left,
      'w', 'a', 'd', 's',
      '8', '6', '2', '4'
      move(k)
    when :alt_l, :look
      m = "[#{point.i}]"
      m << " Looks like the current terrain is #{center.terrain.try(:name)}."
      m << " People camped here: #{point.neighbors(self).map {|c| c.email}.to_sentence}" unless point.neighbors(self).empty?
      m << " Foes: #{point.foes.inspect}" unless point.foes.empty?
      @refreshables[:status] = {:message => m}
    when '?', :help
      @refreshables[:alert] = {:message => HELP_TEXT}
    when :alt_q, :quit
      @refreshables[:confirm] = {
        :ask => "Are you sure you want to quit?",
        :yes => :quit
      }
    else
      @refreshables[:status] = {:message => "Invalid key. Try ? for help."}
    end
  end

  def move(direction)
    new_i = case direction
    when :up, 'w'
      point.i - 100
    when :right, 'd'
      point.i + 1
    when :down, 's'
      point.i + 100
    when :left, 'a'
      point.i - 1
    end
    p = point.map.points.find_by_i(new_i)
    if p.nil?
      @refreshables[:status] = {:message => "Try using the arrow keys"}
    elsif can_walk_on?(p)
      self.hp += rand(3)
      self.hp = self.vitality if self.hp > self.vitality
      @refreshables[:field] = true
      update_attribute(:point, p)
      @refreshables[:status] = {:message => ""}
      @refreshables[:fight] = {:foe => Foe.find(p.foes.rand)} if !p.foes.empty? && rand(15).zero?
      dospecial(*p.special) if p.special?
    else
      message = case p.terrain.try(:slug).try(:to_sym)
      when :water
        "I might be able to go on the water if I had some kind of boat."
      when :mountain
        "That looks unsafe to attempt without proper equipment."
      when :deep_desert
        "Hmm, there must be some way I could survive in the deep desert."
      when :void
        "There's no way I'm walking off the end of the world!"
      else
        "That's way too scary to even think about."
      end
      @refreshables[:status] = {:message => message}
    end
  end

  def dospecial(action, options)
    case action
    when 'item_source'
      bi = BaseItem.find_by_slug(options[:item])
      if bi
        if items.any? {|i| i.slug == bi.slug}
          @refreshables[:status] = {:message => "You already have the #{bi.name}!"}
        else
          @refreshables[:inventory] = true
          if bi.slug.to_sym == :telescope
            @refreshables.delete(:field)
            @refreshables[:whole_field] = true
          end
          @refreshables[:alert] = {:message => "A guru gives you #{bi.name}"}
          items << bi.create_item
        end
      end
    when 'win'
      @refreshables[:confirm] = {
        :ask => "Congratulations, You won!\nWould you like to reset the game?",
        :yes => :reset_game
      }
    end
  end

  def has?(item)
    items.map {|i| i.slug.to_sym}.include? item.to_sym
  end

  def can_walk_on?(p)
    return false if p.blank? || p.terrain.blank?
    case p.try(:terrain).try(:kind).try(:to_sym)
    when :void
      false
    when :mountain
      has? :climbing_gear
    when :water
      has? :kayak
    when :deep_desert
      has? :waterskin
    when nil
      false
    else
      true
    end
  end

  def refreshables
    (r, @refreshables = @refreshables, {}).first
  end

  def reset!
    set_defaults
    puts save!
  end

  private

  def set_defaults
    self.race_id = nil
    self.point = Point.find_by_i(2971)
    self.items = []
    self.name = "Hero"
    self.hp = 25
    self.vitality = 25
    self.strength = 25
    self.agility = 25
    self.gold = 25
    self.magic = 25
    self.magic_kind = 'mage'
  end

end
