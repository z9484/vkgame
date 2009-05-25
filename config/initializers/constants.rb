# Copyright (C) 2009 Daniel Esplin
# Part of the Virtual Kingdoms the Game project. http://www.virtualkingdoms.net/

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2
# or at your option any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY.

# See the COPYING file for more details.

VK_SERVER_URL = 'http://game.ruby.virtualkingdoms.net'

DB_PATH = "#{SHOES_ROOT}/db/db.sqlite3"
SOLO_PATH = "#{SHOES_ROOT}/db/solo.sqlite3"
CREDENTIALS_PATH = "#{SHOES_ROOT}/credentials"

HELP_TEXT = <<HEREDOC
The basic idea of the game is to find the winning hut. You will be aided in your quest by handy gifts from gurus in simple looking huts.

Some keys to try
alt-q: quit
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

BANK_TEXT = <<HEREDOC
Here at the bank we offer you many different and exciting ways to invest your 
hard earned gold. There are five different guilds in which to place your gold, 
each gives 5% interest compounded daily, but have very different benefits. 
The amount of time that your money stays in an account will drastically 
increase those benefits. All guild members will be given access to discounted 
goods from that guild at various specialty bazaars. Unfortunately due to the 
competitive nature between guilds, membership in only one guild at a time is 
permitted.

Healers Guild
Great for the brand new adventurer. 
1 day specialty bazaar, often various healing or mana potions 
3 days 5% off healing prices
7 days 10% off healing prices
14 days 10% off healing prices and free resurrections

Armorers Guild
Great for the professional hero which naturally go through a lot of armor.
1 day specialty bazaar
3 days 3% off
7 days 7% off
14 days 15% off

Weaponsmith Guild
Another guild specialized for the professional hero. With all those monsters out 
there, good weapons are indefensible. 
1 day specialty bazaar, They often sell rare weapons not found anywhere else.
3 days 3% off
7 days 7% off
14 days 15% off

Merchant Guild
If your a hero that is in the business of making money, this is the guild for you.
1 day specialty bazaar, often sell one of kind building plans 
3 days nothing
7 days 3% off all purchases
14 days 5% off everything + 5% on all your sales

Mercenary Guild
This guild is especially suited for Hero Generals. It helps to be in a good terms 
with roaming mercenaries when one plans to siege a castle. 
1 day specialty bazaar, often a few highly discounted recruits or items that help 
to inspire your men in combat.  
3 days 3% off normal recruits
7 days 7% off normal recruits and healers
14 days 10% off all recruits. Lower daily upkeep for armies.
HEREDOC
