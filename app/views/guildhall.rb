# Copyright (C) 2009 Daniel Esplin
# Part of the Virtual Kingdoms the Game project. http://www.virtualkingdoms.net/

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2
# or at your option any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY.

# See the COPYING file for more details.

module VKView

  def show_guildhall(character)
    @a = window :title => "The Guildhall" do

      def update_stats(character)
        @stats.text = <<-HEREDOC
          Gold: #{character.gold}
          Guild Gold: #{character.guild_gold}
          Guild Time: #{character.guild_time} day(s)
          Guild Membership: #{character.guild_membership}
          Guild Status: #{GUILDSTATS[character.guild_status]}
          Team: #{character.team.try(:name) || 'Unaffiliated'}
        HEREDOC
      end

      def update_menu(character)
        @menu.clear do
          flow do
            para 'Guild:'
            button "Join" do
              join_guild(character)
            end
            if character.guild_membership
              button "Deposit" do
                show_deposit(character)
              end
              button "Withdraw" do
                show_withdraw(character)
              end
            end
          end
          flow do
            para 'Team:'
            button 'New' do
              new_team character
            end
            if character.team
              button 'Leave' do
                leave_team character
              end
            else
              button 'Join' do
                join_team character
              end
            end
          end
          flow do
            para 'Misc:'
            button "Learn More" do
              help
            end
            button "Leave" do
              close
            end
          end
        end
      end

      def help
        @body.clear {para(BANK_TEXT)}
      end

      def join_guild(character)
        @body.clear do
          para "Which guild would you like to join?  "
          list_box :items => %w(Healer Armorer Weaponsmith Merchant Mercenary), :width => 130, :choose => 'Healer' do |list|
            @choice.text = list.text
          end
          para "\n"
          if character.guild_membership
            para "Current guild money will be automatically transferred to the new account.\n\n"
          end
          para "A 100 gold deposit is required to join the"
          @choice = para "None selected"
          para "guild\n\n"
          button 'Sign me up!' do
            if @choice.text == character.guild_membership
              @body.clear do
                para "You're already a member of that guild!"
              end
            else
              character.update_attributes({
                :guild_membership => @choice.text,
                :guild_status => 1,
                :guild_time => 0
              })
              update_stats(character)
              update_menu(character)
              @body.clear do
                para "Thanks for joining the guild."
              end
            end
          end
        end
      end

      def deposit(character, amount)
        @body.clear do
          para character.deposit(amount)
        end
        update_stats(character)
      end

      def show_deposit(character)
        @body.clear do
          @amount = edit_line 'all'
          button "OK" do
            deposit character, @amount.text
          end
        end
      end

      def withdraw(character, amount)
        @body.clear do
          para character.withdraw(amount)
        end
        update_stats(character)
      end

      def show_withdraw(character)
        @body.clear do
          @amount = edit_line 'all'
          button "OK" do
            withdraw character, @amount.text
          end
        end
      end

      def new_team(character)
        @body.clear do
          flow :width => 200 do
            para "Creating a new team.\n"
            para "Team name: "
            @name = edit_line
            para "Team Password: "
            @password = edit_line :secret => true
            button 'ok' do
              character.create_team(:name => @name.text, :password => @password.text)
              @body.clear do
                para "You just created #{character.team.name} team"
              end
              update_menu character
              update_stats character
            end
          end
        end
      end

      def join_team(character)
        @body.clear do
          flow :width => 200 do
            para "Joining an existing team.\n"
            @name = list_box :items => Team.all.map {|t| t.name}
            para "Team Password: "
            @password = edit_line :secret => true
            button 'OK' do
              team = Team.find_by_name_and_password(@name.text, @password.text)
              @body.clear do
                if team && character.update_attribute(:team, team)
                  para "You just joined #{team.name} team."
                  update_menu character
                else
                  para "Invalid team or password."
                end
              end
              update_stats character
            end
          end
        end
      end

      def leave_team(character)
        if confirm("Are you sure you want to leave the team?")
          character.update_attribute(:team, nil)
          close
        end
      end

      background BASE_LIGHT..BASE_LIGHTEST
      stack do
        title "The Guildhall"
        @stats = para
        update_stats character
        @menu = stack
        update_menu character
        @body = flow do
          para "Welcome to the Guildhall!"
        end
      end

      keypress do |k|
        case k.to_sym
        when :alt_g
          join_guild(character)
        when :alt_d
          show_deposit(character)
        when :alt_w
          show_withdraw(character)
        when :alt_t
          join_team(character)
        when :alt_h
          help
        when :alt_q
          close
        end
      end

    end
  end
end
