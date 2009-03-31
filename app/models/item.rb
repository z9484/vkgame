# Copyright (C) 2009 Daniel Esplin
# Part of the Virtual Kingdoms the Game project. http://www.virtualkingdoms.net/

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2
# or at your option any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY.

# See the COPYING file for more details.

class Item < ActiveRecord::Base

  belongs_to :base_item
  belongs_to :itemable, :polymorphic => true

  def name; base_item.name; end
  def slug; base_item.slug; end
  def kind; base_item.kind; end

end
