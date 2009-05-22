# Copyright (C) 2009 Daniel Esplin
# Part of the Virtual Kingdoms the Game project. http://www.virtualkingdoms.net/

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2
# or at your option any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY.

# See the COPYING file for more details.

module ArmyView



  def recruit_window(station, character)#, army)
    window do
    character.gold += 10000
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
        if (cost <= character.gold)
          character.gold -= cost
          #character.update_army()   
          close
          alert "Thanks you're #{cost} gold poorer with a total of #{character.gold} gold."
        else
          alert "Invalid transaction. You do not have enough gold!"
        end
      end
      button 'cancel' do
        close
      end
      end

    end
  end

end
