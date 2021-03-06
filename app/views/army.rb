# Copyright (C) 2009 Daniel Esplin
# Part of the Virtual Kingdoms the Game project. http://www.virtualkingdoms.net/

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2
# or at your option any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY.

# See the COPYING file for more details.

module ArmyView
=begin  
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
          if confirm("Are you sure you want to disband your army?")
            #disband_army
            army = character.armies.find_by_camped(false)
            army.destroy
            close
          end	
        end
        button 'split army' do
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

            para "Splitting #{name} army.\n"
            flow :width => 200, :margin_left => 15 do 
              para "Footmen    "
              button '<' do
                if nfootmen > 0
                  ofootmen += 1
                  nfootmen -= 1
                  @p.clear{para "Footmen  ", strong(ofootmen), " : ", strong(nfootmen), "\nArchers    ", strong(oarchers), " : ", strong(narchers), "\nPikemen  ", strong(opikemen), " : ", strong(npikemen), "\nKnights    ", strong(oknights), " : ", strong(nknights), "\nHealers    ", strong(ohealers), " : ", strong(nhealers), "\nCatapults ", strong(ocatapults), " : ", strong(ncatapults)}
             
                end
              end
              button '>' do
                if ofootmen > 0
                  ofootmen -= 1
                  nfootmen += 1
                  @p.clear{para "Footmen  ", strong(ofootmen), " : ", strong(nfootmen), "\nArchers    ", strong(oarchers), " : ", strong(narchers), "\nPikemen  ", strong(opikemen), " : ", strong(npikemen), "\nKnights    ", strong(oknights), " : ", strong(nknights), "\nHealers    ", strong(ohealers), " : ", strong(nhealers), "\nCatapults ", strong(ocatapults), " : ", strong(ncatapults)}
                end
              end
              if narchers > 0 && oarchers > 0
                para "Archers    "
                button '<' do
                  if narchers > 0
                    oarchers += 1
                    narchers -= 1
                    @p.clear{para "Footmen  ", strong(ofootmen), " : ", strong(nfootmen), "\nArchers    ", strong(oarchers), " : ", strong(narchers), "\nPikemen  ", strong(opikemen), " : ", strong(npikemen), "\nKnights    ", strong(oknights), " : ", strong(nknights), "\nHealers    ", strong(ohealers), " : ", strong(nhealers), "\nCatapults ", strong(ocatapults), " : ", strong(ncatapults)}
                  end
                end
                button '>' do
                  if oarchers > 0
                    oarchers -= 1
                    narchers += 1
                    @p.clear{para "Footmen  ", strong(ofootmen), " : ", strong(nfootmen), "\nArchers    ", strong(oarchers), " : ", strong(narchers), "\nPikemen  ", strong(opikemen), " : ", strong(npikemen), "\nKnights    ", strong(oknights), " : ", strong(nknights), "\nHealers    ", strong(ohealers), " : ", strong(nhealers), "\nCatapults ", strong(ocatapults), " : ", strong(ncatapults)}
                  end
                end
              end
              
              if npikemen > 0 && opikemen > 0
                para "Pikemen    "
                button '<' do
                  if npikemen > 0
                    opikemen += 1
                    npikemen -= 1
                    @p.clear{para "Footmen  ", strong(ofootmen), " : ", strong(nfootmen), "\nArchers    ", strong(oarchers), " : ", strong(narchers), "\nPikemen  ", strong(opikemen), " : ", strong(npikemen), "\nKnights    ", strong(oknights), " : ", strong(nknights), "\nHealers    ", strong(ohealers), " : ", strong(nhealers), "\nCatapults ", strong(ocatapults), " : ", strong(ncatapults)}
                  end
                end
                button '>' do
                  if opikemen > 0
                    opikemen -= 1
                    npikemen += 1
                    @p.clear{para "Footmen  ", strong(ofootmen), " : ", strong(nfootmen), "\nArchers    ", strong(oarchers), " : ", strong(narchers), "\nPikemen  ", strong(opikemen), " : ", strong(npikemen), "\nKnights    ", strong(oknights), " : ", strong(nknights), "\nHealers    ", strong(ohealers), " : ", strong(nhealers), "\nCatapults ", strong(ocatapults), " : ", strong(ncatapults)}
                  end
                end
              end
                      
              if nknights > 0 && oknights > 0
                para "Knights    "
                button '<' do
                  if nknights > 0
                    oknights += 1
                    nknights -= 1
                    @p.clear{para "Footmen  ", strong(ofootmen), " : ", strong(nfootmen), "\nArchers    ", strong(oarchers), " : ", strong(narchers), "\nPikemen  ", strong(opikemen), " : ", strong(npikemen), "\nKnights    ", strong(oknights), " : ", strong(nknights), "\nHealers    ", strong(ohealers), " : ", strong(nhealers), "\nCatapults ", strong(ocatapults), " : ", strong(ncatapults)}
                  end
                end
                button '>' do
                  if oknights > 0
                    oknights -= 1
                    nknights += 1
                    @p.clear{para "Footmen  ", strong(ofootmen), " : ", strong(nfootmen), "\nArchers    ", strong(oarchers), " : ", strong(narchers), "\nPikemen  ", strong(opikemen), " : ", strong(npikemen), "\nKnights    ", strong(oknights), " : ", strong(nknights), "\nHealers    ", strong(ohealers), " : ", strong(nhealers), "\nCatapults ", strong(ocatapults), " : ", strong(ncatapults)}
                  end
                end
              end
              
              if nhealers > 0 && ohealers > 0
                para "Healers    "
                button '<' do
                  if nhealers > 0
                    ohealers += 1
                    nhealers -= 1
                    @p.clear{para "Footmen  ", strong(ofootmen), " : ", strong(nfootmen), "\nArchers    ", strong(oarchers), " : ", strong(narchers), "\nPikemen  ", strong(opikemen), " : ", strong(npikemen), "\nKnights    ", strong(oknights), " : ", strong(nknights), "\nHealers    ", strong(ohealers), " : ", strong(nhealers), "\nCatapults ", strong(ocatapults), " : ", strong(ncatapults)}
                  end
                end
                button '>' do
                  if ohealers > 0
                    ohealers -= 1
                    nhealers += 1
                    @p.clear{para "Footmen  ", strong(ofootmen), " : ", strong(nfootmen), "\nArchers    ", strong(oarchers), " : ", strong(narchers), "\nPikemen  ", strong(opikemen), " : ", strong(npikemen), "\nKnights    ", strong(oknights), " : ", strong(nknights), "\nHealers    ", strong(ohealers), " : ", strong(nhealers), "\nCatapults ", strong(ocatapults), " : ", strong(ncatapults)}
                  end
                end
              end
              
              if ncatapults > 0 && ocatapults > 0
                para "Catapults    "
                button '<' do
                  if ncatapults > 0
                    ocatapults += 1
                    ncatapults -= 1
                    @p.clear{para "Footmen  ", strong(ofootmen), " : ", strong(nfootmen), "\nArchers    ", strong(oarchers), " : ", strong(narchers), "\nPikemen  ", strong(opikemen), " : ", strong(npikemen), "\nKnights    ", strong(oknights), " : ", strong(nknights), "\nHealers    ", strong(ohealers), " : ", strong(nhealers), "\nCatapults ", strong(ocatapults), " : ", strong(ncatapults)}
                  end
                end
                button '>' do
                  if ocatapults > 0
                    ocatapults -= 1
                    ncatapults += 1
                    @p.clear{para "Footmen  ", strong(ofootmen), " : ", strong(nfootmen), "\nArchers    ", strong(oarchers), " : ", strong(narchers), "\nPikemen  ", strong(opikemen), " : ", strong(npikemen), "\nKnights    ", strong(oknights), " : ", strong(nknights), "\nHealers    ", strong(ohealers), " : ", strong(nhealers), "\nCatapults ", strong(ocatapults), " : ", strong(ncatapults)}
                  end
                end
              end
              
              @p =flow
       
            end
            flow :margin_left => 15 do
              button 'ok' do
                if (ofootmen > 0 || oarchers > 0 || opikemen > 0 || oknights > 0 || ohealers > 0 || ocatapults > 0) && (nfootmen > 0 || narchers > 0 || npikemen > 0 || nknights > 0 || nhealers > 0 || ncatapults > 0)
                  #original army
                  army.update_attribute(:footmen, ofootmen)
                  army.update_attribute(:archers, oarchers)
                  army.update_attribute(:pikemen, opikemen)
                  army.update_attribute(:knights, oknights)
                  army.update_attribute(:healers, ohealers)
                  army.update_attribute(:catapults, ocatapults)
                  
                  #Create new army
                  a = character.armies.create({
                  :footmen => nfootmen,
                  :archers => narchers,
                  :pikemen => npikemen,
                  :knights => nknights,
                  :healers => nhealers,
                  :catapults => ncatapults,
                  })
                  a.update_attribute(:point, character.point)
                  a.update_attribute(:camped, true)
                  close
                else
                alert "Invalid Selection"
                end
              end
              button 'cancel' do
                close
              end
            end
          end
        end
        button 'merge army' do
          close
          window do 
            background BASE_LIGHT..BASE_LIGHTEST
            army1 = character.armies.find_by_camped(false)
            #army2 = character.armies.find_by_point_id(character.point).and.find_by_camped(true)   
            army2 = character.armies.find(:conditions => { :point_id => character.point, :camped => true})
            if army2
              para "Merging #{name} army.\n"
              flow :width => 250, :margin_left => 15 do 
                para "Footmen    ", army1.footmen, ' + ', army2.footmen, ' = ', army1.footmen + army2.footmen 
              end
              flow :margin_left => 15 do 
                button 'ok' do
                  if confirm("Are you sure you want to merge your army?")
                    army1.update_attribute(:footmen, army1.footmen + army2.footmen)
                    army1.update_attribute(:archers, army1.archers + army2.archers)
                    army1.update_attribute(:pikemen, army1.pikemen + army2.pikemen)
                    army1.update_attribute(:knights, army1.knights + army2.knights)
                    army1.update_attribute(:healers, army1.healers + army2.healers)
                    army1.update_attribute(:catapults, army1.catapults + army2.catapults)
                    army2.destroy
                    close
                  end
                end 
                button 'cancel' do
                  close           
                end
              end
            else
              para "No army to merge.\n"
              button 'ok' do
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


      @p = flow
      @p.clear{para "Hiring ", strong("#{footman}"), " footmen. ", "\nHiring ", strong("#{archer}"), " archers.", "\nHiring ", strong("#{pikeman}"), " pikemen.", "\nHiring ", strong("#{knight}"), " knights.", "\nHiring ", strong("#{healer}"), " healers.", "\nHiring ", strong("#{catapult}"), " catapults.", "\nTotal cost is ", strong("#{cost}")}
 
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
=end
end
