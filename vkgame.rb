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
    ActiveRecord::Base.establish_connection({
      :adapter => 'sqlite3',
      :dbfile => @@db_path,
    })
    @@character = Character.find_or_create_by_email(@@email)
    stack do
      @field = stack :width => 350, :height => 350 do
        show_field(@@character)
      end
      stack :height => 180 do
        background BASE_LIGHT..BASE_DARK
        border BASE_LIGHT, :strokewidth => 3
        @status = stack :height => 60 do
          show_status
        end
        @inventory = stack :height => 70 do
          show_inventory(@@character)
        end
        @menu = stack :height => 30 do
          show_menu @@character
        end
      end
    end
    keypress do |k|
      handle @@character, k
    end
  end

  url '/', :index
  url '/game', :game

end

Shoes.app :title => "VK game", :width => 350, :height => 520
