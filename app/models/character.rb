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
  belongs_to :team
  has_many :items, :as => :itemable
  has_many :actions
  has_many :armies

  before_create :set_defaults
  after_create :create_actions

  def after_initialize
    @refreshables = {}
  end

  def wideview?
    has?(:telescope)
  end

  def field_points
    i, h = point.i, point.map.height
    is = [i - h * 2, i - h, i, i + h, i + h * 2].map do |r|
      [r - 2, r - 1, r, r + 1, r + 2]
    end.flatten
    point.map.points.find(:all, :conditions => {:i => is}, :order => 'i')
  end

  def center
    field_points[field_points.size / 2]
  end
  def do(k, *args)
    return false if k.nil?
    case k.to_sym
    when :up, :right, :down, :left,
      :w, :a, :d, :s,
      :'8', :'6', :'2', :'4'
      move(k)
    when :alt_l, :look
      i = args.first || 12
      p = point.map.points.find_by_i((point.i + i % 5 - 2) + ((i / 5 - 2) * point.map.height))
      m = ''
      if p
        m = "[#{p.i % 50}, #{p.i / 50}]"
        m << " That looks like (a) #{p.terrain.try(:name)}."
        m << " People camped here: #{p.neighbors(self).map {|c| c.email}.to_sentence}" unless p.neighbors(self).empty?
        m << " Foes: #{p.foes.inspect}" unless p.foes.empty?
      end
      @refreshables[:status] = {:message => m}
    when :'i', :army_info
      iarmy = armies.find_by_camped(false)
      if iarmy
        @refreshables[:army_info] = {:message => m}
      else
        m ||= 'No army is following you at the moment!'
      @refreshables[:status] = {:message => m}
      end
    when :'e', :'g', :enter
      if point.terrain.enterable?
        @refreshables[:enter] = true
      else
        @refreshables[:alert] = {:message => "There's nothing to enter here."}
      end
    when :'?', :help
      @refreshables[:alert] = {:message => HELP_TEXT}
    when :'r', :recruit
      @refreshables[:recruit] = {:station => 1}
    when :'c', :camp_army
      army = armies.find_by_camped(false)
      if army
        army.update_attribute(:camped, true)
        m = "Your army will camp here."
      else
        army = armies.find_by_point_id(point.id)
        if army
          army.update_attribute(:camped, false)
          m = "Your army breaks camp and follows you."
        end
      end
      m ||= 'No army here!'
      @refreshables[:status] = {:message => m}
    when :alt_q, :quit
      @refreshables[:confirm] = {
        :ask => "Are you sure you want to quit?",
        :yes => :quit
      }
    else
      @refreshables[:status] = {:message => "'#{k}' is an invalid key. Try ? for help."}
    end
  end

  def move(direction)
    new_i = case direction.to_sym
    when :up, :w, :'8'
      point.i - point.map.height
    when :right, :d, :'6'
      point.i + 1
    when :down, :s, :'2'
      point.i + point.map.height
    when :left, :a, :'4'
      point.i - 1
    end
    p = point.map.points.find_by_i(new_i)
    if p.nil?
      @refreshables[:status] = {:message => "Try using the arrow keys"}
    elsif can_walk_on?(p) && moves > 0
      self.moves -= 1
      self.hp += rand(3)
      self.hp = self.vitality if self.hp > self.vitality
      @refreshables[:field] = true
      @refreshables[:actions] = true
      update_attribute(:point, p)
      @refreshables[:status] = {:message => ""}
      armies.reload.each do |army|
        army.update_attribute(:point, p) unless army.camped
      end
      case p.terrain.kind.to_sym
      when :church
        update_attribute(:hp, vitality)
        @refreshables[:alert] = {:message => "You have been healed!"}
      when :shop
        case p.terrain.slug.to_sym
        when :recruit
          @refreshables[:status] = {:message => "Press g to enter recruiting station"}
        when :shop
          # dospecial
        when :guildhall
          @refreshables[:status] = {:message => "Everyone's welcome at the Guildhall!"}
        else
          @refreshables[:status] = {:message => "This shop is closed."}
        end
      else
        @refreshables[:status] = {:message => ""}
        @refreshables[:fight] = {:foe => Foe.find(p.foes.rand)} if !p.foes.empty? && rand(20).zero?
      end
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
    when :void, :wall
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

  def stats
    <<-HEREDOC
    Moves: #{moves}
    HP: #{hp} / #{vitality}
    Strength: #{strength}
    Agility: #{strength}
    Gold: #{gold}
    Magic: #{magic}
    Guild Time: #{guild_time} day(s)
    Guild Membership: #{guild_membership}
    Guild Status: #{GUILDSTATS[guild_status]}
    HEREDOC
  end

  def deposit(amount)
    amount = gold if amount =~ /all/i
    amount = amount.to_i
    amount = gold if amount > gold
    amount = 0 if amount < 0
    update_attributes({
      :gold => gold - amount,
      :guild_gold => guild_gold + amount,
    })
    "You deposit #{amount} gold into your account."
  end

  def withdraw(amount)
    amount = guild_gold if amount =~ /all/i
    amount = amount.to_i
    amount = guild_gold if amount > guild_gold
    amount = 0 if amount < 0
    update_attributes({
      :gold => gold + amount,
      :guild_gold => guild_gold - amount,
    })
    "You withdraw #{amount} gold from your account."
  end

  def reset!
    set_defaults
    puts save!
  end


  private

  def daily_update
    #update_news
    update_guild_membership
    bank_interest
  end

  def bank_interest
    if account > 0
      account += account * 0.05
      account.to_i!
    end
  end

  def update_guild_membership
    update_attribute(:guild_time, :guild_time + 1)
    if :guild_membership != 'none'
      if :guild_time > 0
        update_attribute(:guild_status, 2)
      elsif :guild_time > 2
        update_attribute(:guild_status, 3)
      elsif :guild_time > 6
        update_attribute(:guild_status, 4)
      elsif :guild_time > 13
        update_attribute(:guild_status, 5)
      end
    end
  end

  def set_defaults
    self.race_id ||= nil
    self.point ||= Map.find_by_name('Small').points.find_by_i(2185)
    self.items ||= []
    self.name ||= "Hero"
    self.hp ||= 25
    self.vitality ||= 25
    self.strength ||= 25
    self.agility ||= 25
    self.gold ||= 25
    self.magic ||= 25
    self.magic_kind ||= 'mage'
    self.guild_membership ||= nil
    self.guild_status ||= 0
    self.guild_time ||= 0
    self.moves ||= 1000
    self.guild_gold ||= 0
  end

  def create_actions
    BaseAction.find_all_by_kind('base').each do |ba|
      actions.create(:base_action => ba)
    end
  end

end
