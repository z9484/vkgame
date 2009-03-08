Shoes.setup do
  gem 'activerecord'
  gem 'activesupport'
  gem 'curb'
end

require 'activerecord'
require 'curb'
require 'app/models/game'

VK_SERVER_URL = 'http://localhost:3000'
GAME_ID = 2
DBPATH = "db/db.sqlite3"

ActiveRecord::Base.establish_connection({
  :adapter => 'sqlite3',
  :dbfile => DBPATH,
})

class VirtualKingdomsGame < Shoes
  show_log

  def index
    stack do
      title "VKGAME"
      download "#{VK_SERVER_URL}/pages/download?id=#{GAME_ID}", :save => DBPATH do |r|
        if (200..300).include?(r.response.headers['Status'].to_i)
          visit '/game'
        else
          para File.read(DBPATH)
        end
      end
      para "Now downloading, please be patient"
    end
  end

  def game
    stack do
      para 'Welcome to the Jungle'
      para Game.all.inspect
      Game.create(:name => "#{rand(1000)}")
      para Game.all.map {|g| g.name}.join(' ')
      button "Quit" do
        para "saving..."
        c = Curl::Easy.new("#{VK_SERVER_URL}/pages/upload?id=#{GAME_ID}")
        c.multipart_form_post = true
        c.http_post(Curl::PostField.file('game[data]', DBPATH))
        if (200..300).include?(c.response_code)
          File.delete(DBPATH)
          exit
        else
          para "Error"
        end
      end
    end
  end

  url '/', :index
  url '/game', :game
end

Shoes.app
