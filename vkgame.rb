# Copyright (C) 2009 Benjamin Esplin
# Part of the Virtual Kingdoms the Game project. http://www.virtualkingdoms.net/

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2
# or at your option any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY.

# See the COPYING file for more details.

require 'rubygems'
require 'active_support'
require 'active_record'
require 'config/boot'
require 'libglade2'

GRASS = "images/terrains/grass.png" 

#class GuiGlade
class VirtualKingdomsGame 
  include GetText
  #include FoeView
  #include ArmyView
  #include FortView
  #include InventoryView
  #include StatsView
  include VKView

  attr :glade
  
  def initialize(path_or_data, root = nil, domain = nil, localedir = nil, flag = GladeXML::FILE)
    bindtextdomain(domain, localedir, nil, "UTF-8")
    @glade = GladeXML.new(path_or_data, root, domain, localedir, flag) {|handler| method(handler)}
    init()
    init_view()
    @glade["newgame"].show_all #comment out for testing purposes.
    #@glade["VKgame"].show_all
    
    
  end
  
  def start_game()
    ActiveRecord::Base.establish_connection({
      :adapter => 'sqlite3',
      :database => @@db_path,
    })
    @@character = Character.find_or_create_by_email(@@email)

    show_field(@@character)

  end

  def init()
    @status = @glade.get_widget("console")
  end

  def init_view()

    x, y = 5, 5
    @view_array = []
    #x.times { @@view_array << Array.new( y ) }  # adding new arrays to m

    for x in 0..24
      @view_array[x] = @glade.get_widget("img#{x}")
    end

=begin
    for x in 0..4
      for y in 0..4
        @@view_array[x][y] = @glade.get_widget("img#{x}_#{y}")
      end
    end
=end
    #show_view()  

  end

  def gtk_widget_show(widget)  
    about = Gtk::AboutDialog.new
	  #about.name = "VK the Game" #deprecated win way 
    about.program_name = "VK the Game"
	  about.version = "0.1"
	  about.copyright = "Copyright (C) 2009 Virtual Kingdoms"
	  about.authors = ["Eremite", "Z9484"]
	  about.artists = ["Shrike"]
	  about.license = "Virtual Kingdoms the Game is released under the GPLv2"
    about.website = "http://game.ruby.virtualkingdoms.net"
    about.comments = "A fantasy re-application of the Door concept\n written in Ruby."
	  about.run
    about.destroy
  end

  def help_dialog(widget)
    dialog = Gtk::MessageDialog.new(nil, 
                                    Gtk::Dialog::DESTROY_WITH_PARENT,
                                    Gtk::MessageDialog::QUESTION,
                                    Gtk::MessageDialog::BUTTONS_CLOSE,
                                    HELP_TEXT)
    dialog.run
    dialog.destroy
  end


  def start_offline(widget)
    @@db_path = SOLO_PATH
    @@email = 'solo'

    start_game()

    @glade["VKgame"].show_all
    @glade["newgame"].hide_all
  end

  def start_online(widget)
    start_offline(widget)
=begin
    emailentry = @glade.get_widget("entry_email")
    passentry = @glade.get_widget("entry_password")
    @@email = emailentry.text
    @@password = passentry.text

    start_game()

    @glade["VKgame"].show_all
    @glade["newgame"].hide_all
=end
  end

  def restart_game(widget)
    @glade["newgame"].show_all
    @glade["VKgame"].hide_all
  end

  def on_look_clicked(widget)
    print_status("Just an empty field.")
  end

  def on_VKgame_key_press_event(widget, k)
    #@test = @glade.get_widget("notebook2")
    handle @@character, k.keyval
  end

=begin
    if (arg0.keyval == 108) # l -> look 
      print_status("Just an empty field.")

    elsif (arg0.keyval == 97) or (arg0.keyval == 65460) or (arg0.keyval == 65361)
      print_status("Moving left.")

    elsif (arg0.keyval == 100) or (arg0.keyval == 65462) or (arg0.keyval == 65363)
      print_status("Moving right.")

    elsif (arg0.keyval == 119) or (arg0.keyval == 65464) or (arg0.keyval == 65362)
      print_status("Moving up.")
      show_field(@@character)

    elsif (arg0.keyval == 115) or (arg0.keyval == 65364) or (arg0.keyval == 65458)
      print_status("Moving down.")

    elsif (arg0.keyval == 63)
      help_dialog(widget)

    elsif (arg0.keyval == 103) or (arg0.keyval == 65461)
      @test.page = 1
      print_status("Entered the store.")

    elsif (arg0.keyval == 104)
      @test.page = 0
      print_status("Just left the store.")

    else
      puts arg0.keyval
    end
  end
=end    

  def quit_message(widget, message)
    dialog = Gtk::Dialog.new("VKgame", widget,
                         Gtk::Dialog::MODAL | Gtk::Dialog::DESTROY_WITH_PARENT,
                         [Gtk::Stock::YES, Gtk::Dialog::RESPONSE_ACCEPT],
                         [Gtk::Stock::NO, Gtk::Dialog::RESPONSE_REJECT])
    
    dialog.vbox.add(Gtk::Label.new(message))
    dialog.show_all

    dialog.run do |response|
      case response
        when Gtk::Dialog::RESPONSE_ACCEPT
          on_VKgame_destroy_event(widget)
      end
      dialog.destroy
    end

  end


  def on_VKgame_destroy_event(widget)
    #quit()
    Gtk::main_quit
  end

  def gtk_main_quit(widget)
    quit_message(widget, "\nAre you sure you want to quit?\n")
  end


  #real Functions
  def print_status(string)
    @status.label = string
  end



end

=begin
class VirtualKingdomsGame #< Shoes
  include FoeView
  include ArmyView
  include FortView
  include InventoryView
  include StatsView
  include VKView

  def game
    ActiveRecord::Base.establish_connection({
      :adapter => 'sqlite3',
      :dbfile => @@db_path,
    })
    @@character = Character.find_or_create_by_email(@@email)

=begin
    show_field(@@character)
    show_inventory(@@character)
    show_status
    show_actions(@@character)
    show_stats(@@character)

    keypress do |k|
      handle @@character, k
    end

  end

end
=end

# Main program
if __FILE__ == $0
  PROG_PATH = "gui.glade"
  PROG_NAME = "Virtual Kingdoms the Game"
  VirtualKingdomsGame.new(PROG_PATH, nil, PROG_NAME)
  Gtk.main
end



