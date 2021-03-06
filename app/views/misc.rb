# Copyright (C) 2009 Daniel Esplin
# Part of the Virtual Kingdoms the Game project. http://www.virtualkingdoms.net/

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2
# or at your option any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY.

# See the COPYING file for more details.

module VKView

=begin
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
        if @@email.blank? || @@password.blank?
          params = ''
        else
          File.open(CREDENTIALS_PATH, 'w') {|f| f << "#{@@email} #{@@password}"} unless File.exists?(CREDENTIALS_PATH)
          params = "?email=#{Utils.escape(@@email)}&password=#{Utils.escape(@@password)}"
        end
        params ||= ''
        download "#{VK_SERVER_URL}/pages/download#{params}", :save => DB_PATH do |r|
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

      @@email, @@password = File.read(CREDENTIALS_PATH).squish.split if File.exists?(CREDENTIALS_PATH)
      @@email ||= ''
      @@password ||= ''
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
          e = edit_line :text => @@email
          para strong "Password:"
          pw = edit_line :secret => true, :text => @@password
        end
        stack :width => 250 do
          b = button "Play the Online\nDoor Version", :height => 100, :width => 225, :margin => 5 do
            @@email, @@password = e.text, pw.text
            door_game
          end
          button "Play the Offline\nSolo Version.", :height => 100, :width => 225, :margin => 5 do
            solo_game
          end
        end
        e.text.blank? ? e.focus : b.focus
      end
      para link VK_SERVER_URL, :click => VK_SERVER_URL, :align => 'center', :width => 600
      keypress do |k|
        case k
        when :alt_q
          exit
        when :alt_s
          solo_game
        when :alt_d
          door_game
        end
      end
      solo_game
    end
  end
=end

  def quit(character = nil)
    unless @@email == 'solo'
      update_status("Saving game, please wait")

      params = {
        :email => @@email,
        :password => @@password,
        :game_data => Zlib::Deflate.deflate(File.read(DB_PATH)),
      }
      r = Net::HTTP.post_form(URI.parse("#{VK_SERVER_URL}/pages/upload"), params)
      if (200..300).include?(r.code.to_i)
        File.delete(DB_PATH)
      else
        puts "Error saving game."
      end
    end
    #exit
  end

  def reset_game(character)
    character.reset!
    @inventory.clear {show_inventory(character)}
    @field.clear {show_field(character)}
    update_status("Game has been reset.")
  end
=begin
  def show_status
    stack :height => 60 do
      background BASE_LIGHTER..BASE_LIGHT
      border BASE_MID, :strokewidth => 5
      @status = para "Find the winning hut. Arrow keys to move.", :margin => 7
    end
  end
=end

  def update_status(message = '')
    @status.label = message
    # @status.scroll_top = @status.scroll_max
  end

=begin
  def show_menu(character)
    flow do
      button "Help", :margin_left => 10 do
        handle character, :help
      end
      button "Look", :margin_left => 10 do
        handle character, :look
      end
    end
  end
=end

  def handle(character, k, *args)
    character.do(k, *args)
    character.refreshables.each do |refreshable, details|
      case refreshable
      when :inventory
        @inventory.clear {show_inventory(character)}
      when :field
        show_field(character) #update_images(character)
      when :enter
        send("show_#{character.point.terrain.slug}", character) if character.point.terrain.enterable?
      when :status
        update_status(details[:message])
      when :fight
        #fight(character, details[:foe]) if details[:foe]
      when :alert
        update_status(details[:message]) #alert(details[:message])
      when :army_info
        army_info(character)
      when :build_fort  
        fort_build(character)
      when :recruit #test function
        fort_window(character)
      when :confirm
        send(details[:yes], character) if confirm(details[:ask])
      when :actions
        update_actions(character)
      end
    end
    #update_stats(character)
  end

  #TODO Move elsewhere
  def show_shop(character)
  end
  def show_armor(character)
  end
  def show_weapons(character)
  end

end
