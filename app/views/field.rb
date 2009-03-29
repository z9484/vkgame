module FieldView

  def show_field(character)
    background BASE_LIGHT
    flow character.field_flow_options do
      @field_images = []
      character.field_points.each do |p|
        stack :width => 68, :height => 68 do
          if character.point == p
            border COMPLEMENT1_LIGHTER, :strokewidth => 5
          else
            border COMPLEMENT2_LIGHTER
          end
          @field_images << image("images/terrains/#{p.terrain.try(:slug)}.png", :width => 60, :height => 60, :margin => [2, 2, 0, 0], :displace_left => 3, :displace_top => 3)
        end
      end
    end
  end

  def update_images(character)
    character.field_points.zip(@field_images) do |p, i|
      if p.terrain.try(:slug).nil?
        puts "Error finding terrain for point #{p.id}"
        i.path = "images/terrains/void.png"
      else
        i.path = "images/terrains/#{p.terrain.try(:slug)}.png"
      end
    end
  end

end
