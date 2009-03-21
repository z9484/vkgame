Shoes.setup do
  gem 'activerecord'
  gem 'activesupport'
  gem 'curb'
end

require 'activerecord'
require 'curb'
Dir['app/models/*'].each do |m|
  require m
end
Dir['app/views/*'].each do |m|
  require m
end

VK_SERVER_URL = 'http://localhost:3000'
GAME_ID = 2
DBPATH = "db/db.sqlite3"


ActiveRecord::Base.establish_connection({
  :adapter => 'sqlite3',
  :dbfile => DBPATH,
})

class VirtualKingdomsGame < Shoes
  include FieldView
  include InventoryView

  # show_log
  @@email = ''
  @@password = ''
  @@character = nil

  def index
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
          @@email = CGI.escape('e@e.com' || e.text)
          @@password = CGI.escape('test' || pw.text)
          params = "id=#{GAME_ID}&email=#{@@email}&password=#{@@password}"
          # download "#{VK_SERVER_URL}/pages/download?#{params}", :save => DBPATH do |r|
          #   if (200..300).include?(r.response.headers['Status'].to_i)
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
    stack do
      @field = stack :width => 350, :height => 350 do
        show_field(@@character)
      end
      stack :height => 150 do
        @bg = background BASE_LIGHT..BASE_DARK
        border BASE_LIGHT, :strokewidth => 3
        stack :height => 75 do
          keys = %w(left right up down q)
          @status = para "Available keys: #{keys.to_sentence}"
          # button "Quit" do
          #   para "saving..."
            # params = "id=#{GAME_ID}&email=#{@@email}&password=#{@@password}"
            # c = Curl::Easy.new("#{VK_SERVER_URL}/pages/upload?#{params}")
            # c.multipart_form_post = true
            # c.http_post(Curl::PostField.file('game[data]', DBPATH))
            # if (200..300).include?(c.response_code)
            #   File.delete(DBPATH)
              # exit
            # else
            #   para "Error"
            # end
          # end
        end
        @inventory= stack :height => 70 do
          show_inventory(@@character)
        end
      end
    end
    keypress do |k|
      @status.text = @@character.do(k)
      @inventory.clear {show_inventory(@@character)} if @@character.refresh?(:inventory)
      update_images(@@character) if @@character.refresh?(:field)
    end
  end

  url '/', :index
  url '/game', :game
end

Shoes.app :title => "VK game", :width => 350
