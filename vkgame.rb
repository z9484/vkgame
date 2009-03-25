Shoes.setup do
  gem 'activesupport >= 2.3.2'
  gem 'activerecord >= 2.3.2'
  gem 'curb'
end

puts 'before boot'
require 'config/boot'
puts 'booted'

Dir['app/models/*'].each do |m|
  require m
end
Dir['app/views/*'].each do |m|
  require m
end
puts 'after apps'

VK_SERVER_URL = 'http://localhost:3000'
GAME_ID = 2
DBPATH = "db/db.sqlite3"

puts 'after constants'

ActiveRecord::Base.establish_connection({
  :adapter => 'sqlite3',
  :dbfile => DBPATH,
})
puts 'after db'

class VirtualKingdomsGame < Shoes
puts 'inside class'
  include StatusView
  include FieldView
  include InventoryView

  # show_log
  @@email = ''
  @@password = ''
  @@character = nil

  def index
    puts 'inside index'
    title "VK game"
    e, pw = '', ''
    stack do
      para "Email:"
      e = edit_line
      para "Password:"
      pw = edit_line :secret => true
      flow do
        b = button "Let the Adventure Begin", :width => 300 do
          para "Downloading... please be patient"
          @@email = Utils.escape('e@e.com' || e.text)
          @@password = Utils.escape('test' || pw.text)
          params = "id=#{GAME_ID}&email=#{@@email}&password=#{@@password}"
          # download "#{VK_SERVER_URL}/pages/download?#{params}", :save => DBPATH do |r|
          #   if (200..300).include?(r.response.headers['Status'].to_i)
          # Character.delete_all
              @@character = Character.find_or_create_by_email(@@email)
              visit '/game'
          #   else
          #     alert File.read(DBPATH)
          #     exit
          #   end
          # end
        end
      end
    end
  end

  def game
    puts 'inside game'
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
