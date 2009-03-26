Shoes.setup do
  gem 'activesupport >= 2.3.2'
  gem 'activerecord >= 2.3.2'
  gem 'curb'
end

require 'config/boot'

class VirtualKingdomsGame < Shoes
  include MiscView
  include FieldView
  include InventoryView

  def game
    @@character = Character.find_or_create_by_email(@@email)
    stack do
      @field = stack :width => 350, :height => 350 do
        show_field(@@character)
      end
      stack :height => 150 do
        background BASE_LIGHT..BASE_DARK
        border BASE_LIGHT, :strokewidth => 3
        @status = stack :height => 75 do
          show_status
        end
        @inventory= stack :height => 70 do
          show_inventory(@@character)
        end
      end
    end
    keypress do |k|
      quit if k == 'q'
      @@character.do(k)
      puts "#{@@character.center.i} #{@@character.center.terrain.slug}"
      @@character.refreshables.each do |refreshable, details|
        case refreshable
        when :inventory
          @inventory.clear {show_inventory(@@character)}
        when :whole_field
          @field.clear {show_field(@@character)}
        when :field
          update_images(@@character)
        when :status
          update_status(details[:message])
        when :alert
          alert(details[:message])
        end
      end
    end
  end

  url '/', :index
  url '/game', :game

end

Shoes.app :title => "VK game", :width => 350
