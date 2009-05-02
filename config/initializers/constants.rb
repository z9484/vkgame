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
q: quit
left arrow, a, or 4: move left
right arrow, d, or 6: move right
up arrow, w, or 8: move up
down arrow, s, or 2: move down
l: look at the current terrain
?: show this help

Good luck!
HEREDOC
