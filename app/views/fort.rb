# Copyright (C) 2009 Daniel Esplin
# Part of the Virtual Kingdoms the Game project. http://www.virtualkingdoms.net/

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2
# or at your option any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY.

# See the COPYING file for more details.

module FortView
  def fort_build(character)
    #character.update_attribute(:gold, 100) #cheating
    cost = 1
    if cost > character.gold
            alert "You do not have enough gold to build a fort!"
    else
      if confirm("Are you sure you want to build a fort for 10,000 gold?")
        window do
          background BASE_LIGHT..BASE_LIGHTEST
          tagline "Creating a new Fort\n"
          para "What would you like to call the fort?  "
          @e = edit_line :width => 200
          para "\n"
          para "Entry Status?\n"  
          @team = radio; para "Team Access", "\n"
          radio; para "Private Access", "\n"

          button 'Ok' do
            if @e.text == ""
              @p.clear{para strong ("Please enter a fort name first.")}
            else
              if (@team.checked?())
                alert "Fort #{@e.text.to_s} with Team access created."
                #f = character.forts.create({
                  #:name => @e.text.to_s,
                  #:share => true,
                #}
              else
                alert "Fort #{@e.text.to_s} with Private access created."
                #f = character.forts.create({
                  #:name => @e.text.to_s,
                  #:share => false,
                #}
              end
              character.update_attribute(:gold, character.gold -= cost)
              close
            end

          end
          button 'Cancel' do
            close
          end
          para "\n"
          @p = flow
    
        end

      end
    end
  end

  def fort_visitor(character)
character.update_attribute(:moves, 1000) #cheating
    window :title => 'Fort Visitors Entrance', :width => 640, :height => 480 do
      background BASE_LIGHT..BASE_LIGHTEST
      para self, "Welcome to fort.name fort.\n"
      button 'Enter' do
        fort_window(character)
        close
      end
      button 'Sales Menu' do
        window do
          background BASE_LIGHT..BASE_LIGHTEST
        end
      end
      button 'Teleport' do
        close
        window :title => 'Teleport Menu' do
          background BASE_LIGHT..BASE_LIGHTEST
          para "Where would you like to go?"
          done_link = link("Newb City") do
            #character.update_attribute(:point, newb_city)
            close
          end  
          para done_link
          #endlink("main",  :click=>"/", :stroke => black, :underline => "none")
          para "\n\n\n"          
          button 'Leave' do
            close
          end
        end
      end
      para "\n\n\n"
      button 'Leave' do
        close
      end

    end  
  end


  def fort_window(character)
    window :width => 640, :height => 480 do
      def defenderslot
        wolf = "images/items/companion/wolf.png"
        hawk = "images/items/companion/hawk.png"
        nothing = "images/items/nothing.png"
        image0 = hawk
        image1 = wolf
        image2 = nothing
        #flow do
        
        
        @box = flow
        @pick = 0
        @choice = nothing.dup
        #rect :width => 80, :height => 55, :top => 30, :left => 0
        animate(4) do
        
          @box.clear{
            @soldier0 = image image0
            @soldier1 = image image1
            @soldier2 = image image2
          }

          @soldier0.click do         
            if @pick == 0
              @pick = 1
              @choice = image0.dup
              @ochoice = 0
            else
              @pick = 0
              if @ochoice == 1 
                image1 = image0.dup
              elsif @ochoice == 2
                image2 = image0.dup
              end
              image0 = @choice.dup
            end
          end

          @soldier1.click do
            if @pick == 0
              @pick = 1
              @choice = image1.dup
              @ochoice = 1
            else
              @pick = 0
              if @ochoice == 0     
                image0 = image1.dup           
              elsif @ochoice == 2
                image2 = image1.dup    
              end          
              image1 = @choice.dup
            end
          end

          @soldier2.click do
            if @pick == 0
              @pick = 1
              @choice = image2.dup
              @ochoice = 2
            else
              @pick = 0
              if @ochoice == 0     
                image0 = image2.dup           
              elsif @ochoice == 1 
                image1 = image2.dup 
              end            
              image2 = @choice.dup
            end
          end

        end

      end #defenderslot

      def moat
        window do
          background BASE_LIGHT..BASE_LIGHTEST
          para "Would you like to pay for a new moat?\n"
          para "None, Water, Alligator Infested, Sea serpent infested, poison"
          button 'ok' do
            close
          end        
          button 'cancel' do
            close
          end

        end
      end

      def gatherers
        window do
          background BASE_LIGHT..BASE_LIGHTEST
          para "Would you like to pay for some gatheres?\n"
          para "All services have a range of 3 from the fort.
          o Dogs -lowest resale value; Chewed up merchandise (with purchase 3 free dogs as defenders)
          o Beggars -slightly higher resale value; Are often known to steal more lucrative items
          o Pages(Lackeys) -highest resale value; highly loyal servants.\n"
          button 'ok' do
            close
          end        
          button 'cancel' do
            close
          end

        end
      end

      def traps
        window do
          background BASE_LIGHT..BASE_LIGHTEST
          para "Would you like to pay for traps?\n"
          para "
          o Trap digger- Goes about digging traps that do low damage to enemy heroes.
          o Landscaper Magician - Plants carniverous plants that do medium damage to enemy heroes.
          o Crazy Trap Magician -Finds the most dangerous creatures to guard your surrounding base.\n"
          button 'ok' do
            close
          end        
          button 'cancel' do
            close
          end

        end
      end

      def teleport
        window :title => 'Teleport Menu' do
          
          background BASE_LIGHT..BASE_LIGHTEST
          if $has_teleport == 1
            para "Where would you like to go?"
            done_link = link("Newb City") do
              #character.update_attribute(:point, newb_city)
              close
            end  
            para done_link
            #endlink("main",  :click=>"/", :stroke => black, :underline => "none")
            para "\n\n\n"          
            button 'Leave' do
              close
            end
          else
            para "Would you like to hire a teleport magician for 0 gold?\n"
            button 'ok' do
			  if character.gold > 5
				  $has_teleport = 1
				  character.update_attribute(:gold, character.gold - 0)
				  close
			  else
			    alert "Sorry you do not have enough gold."
			  end	
            end
            button 'cancel' do
              close
            end
          end
        end
      end

      def healers
        window do
          background BASE_LIGHT..BASE_LIGHTEST
          para "Would you like to hire more healers?\n"
          para "
          o 1 healer - can heal all defenders 3 times in a day.
          o 2 healers - can heal all defenders 6 times in a day.
          o 3 healers - can heal all defenders 9 times in a day.\n"
          button 'ok' do
            close
          end        
          button 'cancel' do
            close
          end

        end
      end

      def swordsman
        window do
          background BASE_LIGHT..BASE_LIGHTEST
          para "Would you like to hire a better swordsman\n"
          para "
          o level 2  all defenders are supplied with the training, weapons, and armor to make them fight at level 2.
          o level 3  all defenders are supplied with the training, weapons, and armor to make them fight at level 3.
          o level 4  all defenders are supplied with the training, weapons, and armor to make them fight at level 4.\n"
          button 'ok' do
            close
          end        
          button 'cancel' do
            close
          end

        end
      end

      def hirelings
        window do
          background BASE_LIGHT..BASE_LIGHTEST
          para "Would you like to hire one of the following?\n"
          para "
          o Herbalist - medkits and mana potions
          o Blacksmith - create weapons or armor
          o Fletcher - Makes arrows
          o Specialist - make some random other item (ie factories)
          o Enchanter - Enchants one weapon or armor every 3(1?) days\n"
          button 'ok' do
            close
          end        
          button 'cancel' do
            close
          end

        end
      end

      #Fort Window Start
      background BASE_LIGHT..BASE_LIGHTEST
$has_teleport = 0
      para "Welcome to {name} Fort\n"
      button 'moat' do
        moat
      end
      button 'gatherers' do
        gatherers
      end
      button 'Traps' do
        traps
      end
      button 'Teleport' do
        teleport
      end
      button 'Healers' do
        healers
      end
      button 'Swordsman' do
        swordsman
      end
      button 'Hirelings' do
        hirelings
      end

      defenderslot
      button 'leave' do
        close
      end
       
    end
  end

end
