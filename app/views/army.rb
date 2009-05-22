# Copyright (C) 2009 Daniel Esplin
# Part of the Virtual Kingdoms the Game project. http://www.virtualkingdoms.net/

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2
# or at your option any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY.

# See the COPYING file for more details.

module ArmyView



  def recruit_window
    window do

      def soldier
        cool = 1+1
      end

      background BASE_LIGHT..BASE_LIGHTEST

      footman = 0
      archer = 0
      pikeman = 0
      knight = 0
      healer = 0
      catapult = 0

      cost = 0
      para "Which would you like to recruit? \n\n"
      #list_box :items => ["Footman", "Archer", "Pikeman", "Knight", "Healer", "Catapult"], :choose => "Footman"

      flow :width => 200, :margin_left => 15 do 
        
        para "Footman  "
        #@what = edit_line :width => 30, :text => '5'
        button '<' do
          if cost > 0 && footman > 0
            cost -= 5
            footman -= 1
          end
          @p.clear{para "Hiring ", strong("#{footman}"), " footmen. ", "\nHiring ", strong("#{archer}"), " archers.", "\nHiring ", strong("#{pikeman}"), " pikemen.", "\nHiring ", strong("#{knight}"), " knights.", "\nHiring ", strong("#{healer}"), " healers.", "\nHiring ", strong("#{catapult}"), " catapults.", "\nTotal cost is ", strong("#{cost}")}
        end
        button '>' do
          cost += 5
          footman += 1
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


      end

      @p = flow
      flow :margin_left => 10 do
      button 'ok' do
        close
        alert "Thanks you're #{cost} gold poorer."
      end
      button 'cancel' do
        close
      end
      end
      #cost = 5 * @what.text.to_i
      #para "Total cost is ", strong("#{cost}")
      #  end
    end
  end

end
