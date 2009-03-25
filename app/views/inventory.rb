module InventoryView

  def show_inventory(character)
    flow :margin => [3, 3, 0, 0] do
      character.items.each do |item|
        stack :width => 85, :height => 60, :margin => [3, 3, 0, 0] do
          background COMPLEMENT2_MID..COMPLEMENT2_DARK
          border BASE_MID
          image "images/items/#{item.kind}/#{item.slug}.png"
        end
      end
    end
  end

end
