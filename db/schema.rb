# Copyright (C) 2009 Daniel Esplin
# Part of the Virtual Kingdoms the Game project. http://www.virtualkingdoms.net/

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2
# or at your option any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY.

# See the COPYING file for more details.

ActiveRecord::Schema.define do

  create_table "actions", :force => true do |t|
    t.integer  "base_action_id"
    t.integer  "character_id"
    t.integer  "count",          :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "armies", :force => true do |t|
    t.integer  "point_id"
    t.integer  "character_id"
    t.integer  "moves"
    t.boolean  "camped"
    t.integer  "footmen"
    t.integer  "archers"
    t.integer  "pikemen"
    t.integer  "knights"
    t.integer  "healers"
    t.integer  "catapults"
  end

  create_table "base_action_items", :force => true do |t|
    t.integer  "base_item_id"
    t.integer  "base_action_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "base_actions", :force => true do |t|
    t.string   "name",       :limit => 128
    t.string   "slug",       :limit => 32
    t.string   "kind",       :limit => 32
    t.integer  "value"
    t.integer  "chance"
    t.integer  "randomness"
    t.integer  "gold"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "base_items", :force => true do |t|
    t.string  "name",   :limit => 128
    t.string  "slug",   :limit => 32
    t.string  "kind",   :limit => 32
    t.integer "value"
    t.integer "gold"
    t.integer "weight"
  end

  create_table "characters", :force => true do |t|
    t.integer  "race_id"
    t.integer  "point_id"
    t.string   "name",       :limit => 32
    t.string   "email"
    t.integer  "kills",                    :default => 0
    t.integer  "runs",                     :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "hp"
    t.integer  "vitality"
    t.integer  "strength"
    t.integer  "agility"
    t.integer  "gold"
    t.integer  "magic"
    t.string   "magic_kind"
    t.integer  "moves"
    t.string   "guild_membership"
    t.integer  "guild_status"
    t.integer  "guild_time" 
  end

  create_table "dojo_actions", :force => true do |t|
    t.integer  "point_id"
    t.integer  "base_action_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "foes", :force => true do |t|
    t.string  "name",       :limit => 128
    t.string  "slug",       :limit => 32
    t.integer "hp"
    t.integer "agility"
    t.integer "strength"
    t.integer "armor"
    t.integer "ranged"
    t.integer "magic"
    t.integer "gold"
    t.integer "randomness"
  end

  create_table "items", :force => true do |t|
    t.integer  "base_item_id"
    t.integer  "itemable_id"
    t.string   "itemable_type"
    t.integer  "value"
    t.integer  "gold"
    t.integer  "weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "equipped",      :default => false
  end

  create_table "maps", :force => true do |t|
    t.string   "name",       :limit => 128
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "points", :force => true do |t|
    t.integer "map_id"
    t.integer "terrain_id"
    t.integer "i"
    t.string  "foes"
    t.string  "special"
  end

  create_table "prizes", :force => true do |t|
    t.integer  "foe_id"
    t.integer  "base_item_id"
    t.integer  "chance"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "races", :force => true do |t|
    t.string   "name",       :limit => 16
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "vitality"
    t.integer  "agility"
    t.integer  "strength"
    t.integer  "magic"
    t.integer  "gold"
  end

  create_table "terrains", :force => true do |t|
    t.string   "name",       :limit => 32
    t.string   "slug",       :limit => 32
    t.string   "color",      :limit => 16
    t.string   "kind"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
