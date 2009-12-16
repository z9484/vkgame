#!/usr/bin/env ruby
#
# This file is gererated by ruby-glade-create-template 1.1.4.
#
require 'libglade2'

GRASS = "images/terrains/grass.png" 

HELP_TEXT = <<HEREDOC
The basic idea of the game is to find the winning hut. You will be aided in your quest by handy gifts from gurus in simple looking huts.

Some keys to try
ctrl-q: quit
left arrow, a, or 4: move left
right arrow, d, or 6: move right
up arrow, w, or 8: move up
down arrow, s, or 2: move down
alt-l: look at the current terrain
c to camp/uncamp your army
i to check status of following armies
?: show this help

Good luck!
HEREDOC

# Real Functions

def print_to_console(string)
  @console = @glade.get_widget("console")
  @console.label = string



end

# GUI stuff

class GuiGlade
  include GetText

  attr :glade
  
  def initialize(path_or_data, root = nil, domain = nil, localedir = nil, flag = GladeXML::FILE)
    bindtextdomain(domain, localedir, nil, "UTF-8")
    @glade = GladeXML.new(path_or_data, root, domain, localedir, flag) {|handler| method(handler)}
    #@glade["newgame"].show_all #comment out for testing purposes.
    show_view()
    @glade["VKgame"].show_all
    
    
  end
  
  def gtk_widget_show(widget)  
    about = Gtk::AboutDialog.new
	  #about.name = "VK the Game" #deprecated way
    about.program_name = "VK the Game"
	  about.version = "0.1"
	  about.copyright = "Copyright (C) 2009 Virtual Kingdoms"
	  about.authors = ["Eremite", "Z9484"]
	  about.artists = ["Shrike"]
	  about.license = "Virtual Kingdoms the Game is released under the GPLv2"
    about.website = "http://ruby.game.virtualkingdoms.net"
    about.comments = "A fantasy re-application of the Door concept\n written in Ruby."
	  about.run
    about.destroy
  end

  def start_offline(widget)
    @glade["VKgame"].show_all
    @glade["newgame"].hide_all
  end

  def start_online(widget)
    @glade["VKgame"].show_all
    @glade["newgame"].hide_all
  end

  def restart_game(widget)
    @glade["newgame"].show_all
    @glade["VKgame"].hide_all
  end

  def on_look_clicked(widget)
    print_to_console("Just an empty field.")
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

  def show_view()

    x, y = 5, 5
    @view_array = []  #initializing m for scope reasons
    x.times { @view_array << Array.new( y ) }  # adding new arrays to m

    
   #test for graphics
    for x in 0..4
      for y in 0..4
        @view_array[x][y] = @glade.get_widget("img#{x}_#{y}")
        @view_array[x][y].file = GRASS
      end
    end

  end

  def on_VKgame_key_press_event(widget, arg0)
    @test = @glade.get_widget("notebook2")
    if (arg0.keyval == 108) # l -> look 
      print_to_console("Just an empty field.")

    elsif (arg0.keyval == 97) or (arg0.keyval == 65460) or (arg0.keyval == 65361)
      print_to_console("Moving left.")

    elsif (arg0.keyval == 100) or (arg0.keyval == 65462) or (arg0.keyval == 65363)
      print_to_console("Moving right.")

    elsif (arg0.keyval == 119) or (arg0.keyval == 65464) or (arg0.keyval == 65362)
      print_to_console("Moving up.")

    elsif (arg0.keyval == 115) or (arg0.keyval == 65364) or (arg0.keyval == 65458)
      print_to_console("Moving down.")

    elsif (arg0.keyval == 63)
      help_dialog(widget)

    elsif (arg0.keyval == 103) or (arg0.keyval == 65461)
      @test.page = 1
      print_to_console("Entered the store.")

    elsif (arg0.keyval == 104)
      @test.page = 0
      print_to_console("Just left the store.")

    else
      puts arg0.keyval
    end
    
  end

  def quick_message(widget, message)
    # Create the dialog
    dialog = Gtk::Dialog.new("VKgame", widget,
                         Gtk::Dialog::MODAL | Gtk::Dialog::DESTROY_WITH_PARENT,
                         [Gtk::Stock::YES, Gtk::Dialog::RESPONSE_ACCEPT],
                         [Gtk::Stock::NO, Gtk::Dialog::RESPONSE_REJECT])
    
    # Add the message in a label, and show everything we've added to the dialog.
    dialog.vbox.add(Gtk::Label.new(message))
    dialog.show_all

    dialog.run do |response|
      case response
        when Gtk::Dialog::RESPONSE_ACCEPT
          Gtk::main_quit
      end
      dialog.destroy
    end


  end

  def gtk_main_quit(widget)
    quick_message(widget, "\nAre you sure you want to quit?\n")
  end

  def gtk_widget_destroy(widget)
    puts "dd" #@glade["aboutdialog"].hide
  end

end




# Main program
if __FILE__ == $0
  # Set values as your own application. 
  PROG_PATH = "gui.glade"
  PROG_NAME = "YOUR_APPLICATION_NAME"
  GuiGlade.new(PROG_PATH, nil, PROG_NAME)
  Gtk.main
end
