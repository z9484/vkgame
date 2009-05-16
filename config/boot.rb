# Copyright (C) 2009 Daniel Esplin
# Part of the Virtual Kingdoms the Game project. http://www.virtualkingdoms.net/

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2
# or at your option any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY.

# See the COPYING file for more details.

require 'activerecord'

SHOES_ROOT = "#{File.dirname(__FILE__)}/.." unless defined?(SHOES_ROOT)

[
  'config/initializers/*',
  'app/models/*',
].each do |path|
  Dir["#{SHOES_ROOT}/#{path}"].each do |file|
    require file
  end
end

if ENV["SHOES_ENV"] == "test"
  ActiveRecord::Base.establish_connection({
    :adapter => 'sqlite3',
    :dbfile => SOLO_PATH,
  })
else
  [
    'config/shoes/*',
    'app/views/*',
  ].each do |path|
    Dir["#{SHOES_ROOT}/#{path}"].each do |file|
      require file
    end
  end
end
