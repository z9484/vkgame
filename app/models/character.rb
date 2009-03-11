class Character < ActiveRecord::Base

  belongs_to :point

  before_save :init

  def wideview?
    false
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
      "Try using the arrow keys"
    elsif can_walk_on?(p)
      self.point = p
      "You walk on the #{p.terrain.name}"
    else
      "The #{p.terrain.name} are too dangerous"
    end
  end

  def can_walk_on?(p)
    return false if p.blank? || p.terrain.blank?
    !%w(000000 0000ff).include?(p.terrain.color)
  end

  private

  def init
    self.race_id = nil
    self.point_id = Point.find_by_i(1050).id
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
