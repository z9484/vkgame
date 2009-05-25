# Copyright (C) 2009 Daniel Esplin
# Part of the Virtual Kingdoms the Game project. http://www.virtualkingdoms.net/

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2
# or at your option any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY.

# See the COPYING file for more details.

module ArmyView

  def bank_window(character)
    window do
      background BASE_LIGHT..BASE_LIGHTEST
      @account = 0
      para "Welcome to the local bank. What would you like to do?\n\n"
      flow  :margin_left => 15 do
        inv = button 'Make an investment.' do
          @p.clear{para "\n\nHow much would you like to invest in the guild?\n"  #{character.guild_membership} 
            para "You currently have ", strong("#{character.gold}"), " gold and ", strong("#{@account}"), " gold in your account."
            @e = edit_line 
            button "Invest" do
              if character.gold > 0
                @account += @e.text.to_i
                character.update_attribute(:gold, character.gold - @e.text.to_i)
                #alert @e.text
                @e.text = ''
                
              end
            end
            button "Withdraw" do
              if @account > 0
                @account -= @e.text.to_i
                character.update_attribute(:gold, character.gold + @e.text.to_i)
                #alert @e.text
              @e.text = ''
              end
            end
          }
        end
#        @a = flow

       
        button 'Join a guild.' do
          @p.clear{para "\n\nWhich guild would you like to join?  "
          list_box :items => ['Healer', 'Armorer', 'Weaponsmith', 'Merchant', 'Mercenary'], :width => 130, :choose => 'Healer' do |list|
             @choice.text = list.text
          end
          para "\n"
          para "A 100 gold deposit is required to join the "
          @choice = para "None selected"
          para "guild\n\n"
          button 'Sign me up!' do
            alert @choice
            character.update_attribute(:guild_membership, @choice)
          end}
        end
        button 'Learn more.' do
          #alert BANK_TEXT
          @p.clear{para "\n\n"
            para BANK_TEXT
          }
        end
       @p = flow
       para "\n\n\n\n"
       button 'Leave.' do
        close
        end

      end
    end 
  end

  

  def army_info(character)
    window do 
      background BASE_LIGHT..BASE_LIGHTEST
      army = character.armies.find_by_camped(false)

      para "The status of the #{name} army.   (name   \"ready soldiers\" : \"injured soldiers\")\n"
      para "This army has #{army.moves} moves left.\n"
      flow :width => 150, :margin_left => 15 do 
        if army.footmen > 0
          para "Footmen    ", strong(army.footmen)
        end
        if army.archers > 0
          para "Archers      ", strong(army.archers)
        end 
        if army.pikemen > 0
          para "Pikemen    ", strong(army.pikemen)
        end
        if army.knights > 0
          para "Knights      ", strong(army.knights)
        end
        if army.healers > 0
          para "Healers     ", strong(army.healers)       
        end
        if army.catapults > 0
          para "Catapults  ", strong(army.catapults)       
        end
      end
      flow :margin_left => 15 do
        button 'disband army' do
#         @refreshables[:confirm] = {
#        :ask => "Are you sure you want to disband your army?",
#        :yes => :disband_army
#      }
        end
        button 'merge or split army' do
          close
          #merge(character)
          window do 
            background BASE_LIGHT..BASE_LIGHTEST
            army = character.armies.find_by_camped(false)
            ofootmen = army.footmen; nfootmen = 0
            oarchers = army.archers; narchers = 0
            opikemen = army.pikemen; npikemen = 0
            oknights = army.knights; nknights = 0
            ohealers = army.healers; nhealers = 0
            ocatapults = army.catapults; ncatapults = 0

            para "Merging #{name} army.\n"
            flow :width => 250, :margin_left => 15 do 
              para "Footmen    "
              button '<' do
                if nfootmen > 0
                  ofootmen += 1
                  nfootmen -= 1
                  @p.clear{para strong(ofootmen), " ", strong(nfootmen)}
                end
              end
              button '>' do
                if ofootmen > 0
                  ofootmen -= 1
                  nfootmen += 1
                  @p.clear{para strong(ofootmen), " ", strong(nfootmen)}
                end
              end
              @p =flow
=begin
              para "Archers      ", strong(army.archers)
              para "Pikemen    ", strong(army.pikemen)
              para "Knights      ", strong(army.knights)
              para "Healers     ", strong(army.healers)       
              para "Catapults  ", strong(army.catapults)
=end
       
            end
            flow :margin_left => 15 do
              button 'ok' do
                a = character.armies.create({
                :footmen => nfootmen,
                :archers => narchers,
                :pikemen => npikemen,
                :knights => nknights,
                :healers => nhealers,
                :catapults => ncatapults,
                })
                a.update_attribute(:camped, true)
                close
              end
              button 'cancel' do
                close
              end
            end
          end
        end
        button 'rename army' do
        end
        button 'ok' do
          close
        end
      end
    end
  end


=begin
            character.update_attribute(:gold, character.gold - cost)
            a = character.armies.create({
              :footmen => footman,
              :archers => archer,
              :pikemen => pikeman,
              :knights => knight,
              :healers => healer,
              :catapults => catapult,
            })
=end


  def recruit_window(character, station)
    window do
    #character.gold += 10000
      background BASE_LIGHT..BASE_LIGHTEST

      footman = 0
      archer = 0
      pikeman = 0
      knight = 0
      healer = 0
      catapult = 0

      cost = 0

      #stations = {:station1 => ["Hiring ", strong("#{footman}"), " footmen. ", "\nHiring ", strong("#{archer}"), " archers.", "\nHiring ", strong("#{pikeman}"), " pikemen.", "\nHiring ", strong("#{knight}"), " knights.", "\nHiring ", strong("#{healer}"), " healers.", "\nHiring ", strong("#{catapult}"), " catapults.", "\nTotal cost is ", strong("#{cost}")]}

      para "With #{character.gold} gold, which would you like to recruit? \n\n"
     # para army.footmen

      flow :width => 200, :margin_left => 15 do
        if station == 1
          para "Footman  "
          button '<' do
            if cost > 0 && footman > 0
              cost -= 5
              footman -= 1
            end
     #       @p.clear{para stations[:station1]}
            @p.clear{para "Hiring ", strong("#{footman}"), " footmen. ", "\nHiring ", strong("#{archer}"), " archers.", "\nHiring ", strong("#{pikeman}"), " pikemen.", "\nHiring ", strong("#{knight}"), " knights.", "\nHiring ", strong("#{healer}"), " healers.", "\nHiring ", strong("#{catapult}"), " catapults.", "\nTotal cost is ", strong("#{cost}")}
          end
          button '>' do
            cost += 5
            footman += 1
             #@p.clear{para stations[:station1]}
            @p.clear{para "Hiring ", strong("#{footman}"), " footmen. ", "\nHiring ", strong("#{archer}"), " archers.", "\nHiring ", strong("#{pikeman}"), " pikemen.", "\nHiring ", strong("#{knight}"), " knights.", "\nHiring ", strong("#{healer}"), " healers.", "\nHiring ", strong("#{catapult}"), " catapults.", "\nTotal cost is ", strong("#{cost}")}
          end

          para "Archers  "
          button '<' do
            if cost > 0 and archer > 0
              cost -= 8
              archer -= 1
            end
            @p.clear{para "Hiring ", strong("#{footman}"), " footmen. ", "\nHiring ", strong("#{archer}"), " archers.", "\nHiring ", strong("#{pikeman}"), " pikemen.", "\nHiring ", strong("#{knight}"), " knights.", "\nHiring ", strong("#{healer}"), " healers.", "\nHiring ", strong("#{catapult}"), " catapults.", "\nTotal cost is ", strong("#{cost}")}
          end
          button '>' do
            cost += 8
            archer += 1
            @p.clear{para "Hiring ", strong("#{footman}"), " footmen. ", "\nHiring ", strong("#{archer}"), " archers.", "\nHiring ", strong("#{pikeman}"), " pikemen.", "\nHiring ", strong("#{knight}"), " knights.", "\nHiring ", strong("#{healer}"), " healers.", "\nHiring ", strong("#{catapult}"), " catapults.", "\nTotal cost is ", strong("#{cost}")}
          end

          para "Pikemen  "
          button '<' do
            if cost > 0 and pikeman > 0
              cost -= 10
              pikeman -= 1
            end
            @p.clear{para "Hiring ", strong("#{footman}"), " footmen. ", "\nHiring ", strong("#{archer}"), " archers.", "\nHiring ", strong("#{pikeman}"), " pikemen.", "\nHiring ", strong("#{knight}"), " knights.", "\nHiring ", strong("#{healer}"), " healers.", "\nHiring ", strong("#{catapult}"), " catapults.", "\nTotal cost is ", strong("#{cost}")}
          end
          button '>' do
            cost += 10
            pikeman += 1
            @p.clear{para "Hiring ", strong("#{footman}"), " footmen. ", "\nHiring ", strong("#{archer}"), " archers.", "\nHiring ", strong("#{pikeman}"), " pikemen.", "\nHiring ", strong("#{knight}"), " knights.", "\nHiring ", strong("#{healer}"), " healers.", "\nHiring ", strong("#{catapult}"), " catapults.", "\nTotal cost is ", strong("#{cost}")}
          end

          para "Knights  "
          button '<' do
            if cost > 0 and knight > 0
              cost -= 25
              knight -= 1
            end
            @p.clear{para "Hiring ", strong("#{footman}"), " footmen. ", "\nHiring ", strong("#{archer}"), " archers.", "\nHiring ", strong("#{pikeman}"), " pikemen.", "\nHiring ", strong("#{knight}"), " knights.", "\nHiring ", strong("#{healer}"), " healers.", "\nHiring ", strong("#{catapult}"), " catapults.", "\nTotal cost is ", strong("#{cost}")}
          end
          button '>' do
            cost += 25
            knight += 1
            @p.clear{para "Hiring ", strong("#{footman}"), " footmen. ", "\nHiring ", strong("#{archer}"), " archers.", "\nHiring ", strong("#{pikeman}"), " pikemen.", "\nHiring ", strong("#{knight}"), " knights.", "\nHiring ", strong("#{healer}"), " healers.", "\nHiring ", strong("#{catapult}"), " catapults.", "\nTotal cost is ", strong("#{cost}")}
          end

          para "Healers  "
          button '<' do
            if cost > 0 and healer > 0
              cost -= 50
              healer -= 1
            end
            @p.clear{para "Hiring ", strong("#{footman}"), " footmen. ", "\nHiring ", strong("#{archer}"), " archers.", "\nHiring ", strong("#{pikeman}"), " pikemen.", "\nHiring ", strong("#{knight}"), " knights.", "\nHiring ", strong("#{healer}"), " healers.", "\nHiring ", strong("#{catapult}"), " catapults.", "\nTotal cost is ", strong("#{cost}")}
          end
          button '>' do
            cost += 50
            healer += 1
            @p.clear{para "Hiring ", strong("#{footman}"), " footmen. ", "\nHiring ", strong("#{archer}"), " archers.", "\nHiring ", strong("#{pikeman}"), " pikemen.", "\nHiring ", strong("#{knight}"), " knights.", "\nHiring ", strong("#{healer}"), " healers.", "\nHiring ", strong("#{catapult}"), " catapults.", "\nTotal cost is ", strong("#{cost}")}
          end

          para "Catapults  "
          button '<' do
            if cost > 0 and catapult > 0
              cost -= 150
              catapult -= 1
            end
            @p.clear{para "Hiring ", strong("#{footman}"), " footmen. ", "\nHiring ", strong("#{archer}"), " archers.", "\nHiring ", strong("#{pikeman}"), " pikemen.", "\nHiring ", strong("#{knight}"), " knights.", "\nHiring ", strong("#{healer}"), " healers.", "\nHiring ", strong("#{catapult}"), " catapults.", "\nTotal cost is ", strong("#{cost}")}
          end
          button '>' do
            cost += 150
            catapult += 1
            @p.clear{para "Hiring ", strong("#{footman}"), " footmen. ", "\nHiring ", strong("#{archer}"), " archers.", "\nHiring ", strong("#{pikeman}"), " pikemen.", "\nHiring ", strong("#{knight}"), " knights.", "\nHiring ", strong("#{healer}"), " healers.", "\nHiring ", strong("#{catapult}"), " catapults.", "\nTotal cost is ", strong("#{cost}")}
          end

        #elsif station == 2
        end #if
      end

      @p = flow
      flow :margin_left => 10 do
        button 'ok' do
          if cost == 0
            close
            alert 'Congratulations you recruited no one!'
          elsif cost > character.gold
            alert "Invalid transaction. You do not have enough gold!"
          else
            character.update_attribute(:gold, character.gold - cost)
            a = character.armies.create({
              :footmen => footman,
              :archers => archer,
              :pikemen => pikeman,
              :knights => knight,
              :healers => healer,
              :catapults => catapult,
            })
            close
            alert "Thanks, you're #{cost} gold poorer with a total of #{character.gold} gold."
          end
        end
        button 'cancel' do
          close
        end
      end
    end
  end

end
