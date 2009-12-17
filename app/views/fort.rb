# Copyright(C) 2009 Daniel Esplin
# Part of the Virtual Kingdoms the Game project. http://www.virtualkingdoms.net/

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2
# or at your option any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY.

# See the COPYING file for more details.

module FortView
=begin
  def fort_build(character)
    #character.update_attribute(:gold, 100) #cheating
    fortcost = 1
    if fortcost > character.gold
            alert "You do not have enough gold to build a fort!"
    else
      if confirm("Are you sure you want to build a fort for #{fortcost} gold?")
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
              @p.clear{para strong("Please enter a fort name first.")}
            else
              if(@team.checked?())
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
              character.update_attribute(:gold, character.gold -= fortcost)
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
          @choice0 = radio; para strong("None"), "\n"
          @choice1 = radio; para strong("Water"), " $1 - A mostly ornamental defense.\n"
          @choice2 = radio; para strong("Alligator Infested"), " $5 \n"
          @choice3 = radio; para strong("Sea serpent infested"), " $10 \n"
          @choice4 = radio; para strong("Poison swamp"), " $30 \n"
          button 'ok' do
            close
          end        
          button 'cancel' do
            close
          end

        end
      end

      def gatherers
        window :width => 640, :height => 480 do
          background BASE_LIGHT..BASE_LIGHTEST
          para "Would you like to pay for some gatherers?\n"
          para "All services have a range of 3 from the fort.\n"
          @choice0 = radio; para strong("None"), "\n"
          @choice1 = radio; para strong("Dogs"), " $1 -lowest resale value; Chewed up merchandise(with purchase 3 free dogs as defenders)\n"
          @choice2 = radio; para strong("Beggars"), " $5 -slightly higher resale value; Are often known to steal more lucrative items\n"
          @choice3 = radio; para strong("Pages(Lackeys)"), " $10 -highest resale value; highly loyal servants.\n"
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
          @choice0 = radio; para strong("None"), "\n"
          @choice1 = radio; para strong("Trap digger"), " $1 - Goes about digging traps that do low damage to enemy heroes.\n"
          @choice2 = radio; para strong("Landscaper Magician"), " $5 - Plants carniverous plants that do medium damage to enemy heroes.\n"
          @choice3 = radio; para strong("Crazy Trap Magician"), " $10 -Finds the most dangerous creatures to guard your surrounding base.\n"
          button 'ok' do
=begin            if(@choice0.checked?())
              close
            else if(@choice1.checked?())
              cost = 1
            else if(@choice2.checked?())
              cost = 5
            else if(@choice3.checked?())
              cost = 10
            end

            if cost > character.gold
              @p.clear{para strong("You do not have enough gold!")}
            else
              if confirm("Are you sure you want to spend #{cost} gold?")
                close
              end
            end
          end        
          button 'cancel' do
            close
          end
          @p = flow
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
          @choice0 = radio; para strong("1 healer"), " - can heal all defenders 3 times in a day.\n"
          @choice1 = radio; para strong("2 healers"), " $1 - can heal all defenders 6 times in a day.\n"
          @choice2 = radio; para strong("3 healers"), " $5 - can heal all defenders 9 times in a day.\n"
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
          @choice0 = radio; para strong("None"), "\n"
          @choice1 = radio; para strong("Level 2"), " $1 all defenders are supplied with the training, weapons, and armor to make them fight at level 2.\n"
          @choice2 = radio; para strong("Level 3"), " $5 all defenders are supplied with the training, weapons, and armor to make them fight at level 3.\n"
          @choice3 = radio; para strong("Level 4"), " $10  all defenders are supplied with the training, weapons, and armor to make them fight at level 4.\n"
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
          @choice0 = radio; para strong("None"), "\n"
          @choice1 = radio; para strong("Herbalist"), " $100 - medkits and mana potions\n"
          @choice2 = radio; para strong("Blacksmith"), " $100 - create weapons or armor\n"
          @choice3 = radio; para strong("Fletcher"), " $100 - Makes arrows\n"
          @choice4 = radio; para strong("Specialist"), " $100 - make some other items\n"
          @choice5 = radio; para strong("Enchanter"), " $200 - Enchants one weapon or armor every 3(1?) days\n"
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
=end
end
