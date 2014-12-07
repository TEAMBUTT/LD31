knight
.module("Game")
.component("map",
{"event", "world", "palette", "Platform", "FloatyPlatform"},
function(event, world, palette, Platform, FloatyPlatform)
  local height = love.graphics.getHeight()

  local floor = Platform:new(0, height - 32, 1024, 32)
  local left_wall = Platform:new(-100, 0, 100, height)
  local right_wall = Platform:new(1024, 0, 100, height)
  local ceiling = Platform:new(0, -100, 1024, 100)

  FloatyPlatform:new( 6, 15)
  FloatyPlatform:new(14, 11)
  FloatyPlatform:new(25, 43)
  FloatyPlatform:new(36, 24)
end)
