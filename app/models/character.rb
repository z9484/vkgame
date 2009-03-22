class Character < ActiveRecord::Base

  belongs_to :point
  has_many :items, :as => :itemable

  before_create :set_defaults

  def after_initialize
    @refreshables = {}
  end

  def wideview?
    true
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
    move(k)
  end

  def move(direction)
    new_i = case direction
    when :up
      point.i - 100
    when :right
      point.i + 1
    when :down
      point.i + 100
    when :left
      point.i - 1
    end
    p = point.map.points.find_by_i(new_i)
    if p.nil?
      @refreshables[:status] = {:message => "Try using the arrow keys"}
    elsif can_walk_on?(p)
      @refreshables[:field] = true
      update_attribute(:point, p)
      dospecial(*p.special) if p.special?
      @refreshables[:status] = {:message => "You walk on the #{p.terrain.name}"}
    else
      @refreshables[:status] = {:message => "The #{p.terrain.try(:name)} is too dangerous"}
    end
  end

  def dospecial(action, options)
    case action
    when 'item_source'
      bi = BaseItem.find_by_slug(options[:item])
      if bi && !items.any? {|i| i.slug == bi.slug}
        @refreshables[:inventory] = true
        items << bi.create_item
      end
    end
  end

  def has?(item)
    items.map {|i| i.slug.to_sym}.include? item.to_sym
  end

  def can_walk_on?(p)
    return false if p.blank? || p.terrain.blank?
    case p.try(:terrain).try(:color)
    when '000000'
      has? :climbing_gear
    when '0000ff'
      has? :kayak
    when nil
      false
    else
      true
    end
  end

  def refresh?(e)
    r = @refreshables[e]
    @refreshables.delete(e) unless r.is_a?(Hash)
    r
  end

  def refreshed(e)
    @refreshables.delete(e)
  end

  private

  def set_defaults
    self.race_id = nil
    self.point_id = Point.find_by_i(2971).id
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
