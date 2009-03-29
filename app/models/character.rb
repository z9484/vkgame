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
    has?(:shades)
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
      'k', 'l', 'j', 'h',
      '8', '6', '2', '4'
      move(k)
    when '?'
      @refreshables[:alert] = {:message => HELP_TEXT}
    else
      @refreshables[:status] = {:message => "Invalid key. Try ? for help."}
    end
  end

  def move(direction)
    new_i = case direction
    when :up, 'k'
      point.i - 100
    when :right, 'l'
      point.i + 1
    when :down, 'j'
      point.i + 100
    when :left, 'h'
      point.i - 1
    end
    p = point.map.points.find_by_i(new_i)
    if p.nil?
      @refreshables[:status] = {:message => "Try using the arrow keys"}
    elsif can_walk_on?(p)
      @refreshables[:field] = true
      update_attribute(:point, p)
      @refreshables[:status] = {:message => "You walk on the #{p.terrain.name}"}
      puts p.special.inspect
      dospecial(*p.special) if p.special?
    else
      @refreshables[:status] = {:message => "The #{p.terrain.try(:name)} is too dangerous"}
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
          if bi.slug.to_sym == :shades
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
      has? :stillsuit
    when nil
      false
    else
      true
    end
  end

  def refreshables
    (r, @refreshables = @refreshables, {}).first
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
