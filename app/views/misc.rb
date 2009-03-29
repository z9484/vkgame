module MiscView

  def index
    para "Virtual Kingdoms"
    window do
      def solo_game
        @@db_path = SOLO_PATH
        @@email = 'solo'
        owner.visit '/game'
        close
      end
      def door_game
        @@db_path = DB_PATH
        @content.clear do
          i = nil
          stack do
            para "Downloading... please be patient"
            i = image
          end
          animate(3) do
            i.path = Dir["images/**/*.png"].rand
          end
        end
        File.open(CREDENTIALS_PATH, 'w') {|f| f << "#{@@email} #{@@password}"} unless File.exists?(CREDENTIALS_PATH)
        params = "email=#{@@email}&password=#{@@password}"
        download "#{VK_SERVER_URL}/pages/download?#{params}", :save => DB_PATH do |r|
          if (200..300).include?(r.response.headers['Status'].to_i)
            owner.visit '/game'
            close
          else
            alert File.read(DB_PATH)
            exit
          end
        end
      end

      background BASE_LIGHT..BASE_LIGHTEST
      background COMPLEMENT2_DARK..COMPLEMENT2_MID, :height => 65

      @@email, @@password = '', ''
      @@email, @@password = File.read(CREDENTIALS_PATH).squish.split if File.exists?(CREDENTIALS_PATH)
      e, pw = '', ''
      title "Virtual Kingdoms: The Game"
      flow :margin => [10, 15] do
        para "Welcome to"
        para strong("Virtual Kingdoms: The Game,")
        para "a re-application of the old school door game concept where you can walk around and explore the world."
      end

      @content = flow :margin => 10 do
        stack :width => 260 do
          para "Enter your information if you have already signed up."
          para strong "Email:"
          e = edit_line :text => @@email.gsub('%40', '@')
          para strong "Password:"
          pw = edit_line :secret => true, :text => @@password
        end
        stack :width => 250 do
          b = button "Play the Online\nDoor Version", :height => 100, :width => 225, :margin => 5 do
            @@email, @@password = Utils.escape(e.text), Utils.escape(pw.text)
            door_game
          end
          button "Play the Offline\nSolo Version.", :height => 100, :width => 225, :margin => 5 do
            solo_game
          end
        end
        e.text.blank? ? e.focus : b.focus
      end
      para link "vkgame.virtualkingdoms.net", :click => "http://vkgame.virtualkingdoms.net", :align => 'center', :width => 600
      keypress do |k|
        case k
        when 'q'
          exit
        when 's'
          solo_game
        when 'd'
          door_game
        end
      end
    end
  end

  def quit
    unless @@email == 'solo'
      update_status("Saving game, please wait")
      params = "email=#{@@email}&password=#{@@password}"
      c = Curl::Easy.new("#{VK_SERVER_URL}/pages/upload?#{params}")
      c.multipart_form_post = true
      c.http_post(Curl::PostField.file('game[data]', DB_PATH))
      if (200..300).include?(c.response_code)
        File.delete(DB_PATH)
      else
        puts "Error saving game."
      end
    end
    exit
  end

  def reset_game
    @@character.destroy
    @@character = Character.find_or_create_by_email(@@email)
    @inventory.clear {show_inventory(@@character)}
    @field.clear {show_field(@@character)}
    update_status("Game has been reset.")
  end

  def show_status
    @statusline = para "Find the winning hut. Arrow keys to move."
  end

  def update_status(message = '')
    @statusline.text = message
  end

end
