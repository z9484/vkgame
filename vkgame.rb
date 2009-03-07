Shoes.setup do
  gem 'activerecord'
  gem 'activesupport'
  gem 'curb'
end

require 'activerecord'
require 'curb'

VK_SERVER_URL = 'http://localhost:3000'
GAME_ID = 1
DBFILE = 'db.sqlite3'
DBPATH = "db/#{DBFILE}"

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :dbfile => DBFILE
)

class VirtualKingdomsGame < Shoes
  show_log

  def index
    stack do
      title "VKGAME"
      download "#{VK_SERVER_URL}/pages/download?id=#{GAME_ID}", :save => DBPATH do
        visit '/game'
      end
      para "Now downloading, please be patient"
    end
  end

  def game
    stack do
      para 'Welcome to the jungle'
      button "Quit" do
        para "saving..."
        c = Curl::Easy.new("#{VK_SERVER_URL}/pages/upload?id=#{GAME_ID}")
        c.multipart_form_post = true
        c.http_post(Curl::PostField.content('game[data]', DBPATH))
        exit
      end
    end
  end

  url '/', :index
  url '/game', :game
end

Shoes.app
