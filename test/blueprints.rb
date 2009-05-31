Character.blueprint do
  name "Hero"
end

Point.blueprint do
  terrain
  i 1000
  foes []
  special nil
end

Terrain.blueprint do
  name 'Grass'
  slug 'grass'
  color '00ff00'
  kind 'grass'
end

Action.blueprint do
  character
  base_action
end

BaseAction.blueprint do
  slug 'camp'
  name 'Camp'
  kind 'base'
  gold 0
  value 0
  randomness 0
  chance 0
end
