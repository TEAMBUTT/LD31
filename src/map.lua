knight
.module("Game")
.component("map",
{"event", "world", "palette", "Platform", "FloatyPlatform"},
function(event, world, palette, Platform, FloatyPlatform)
  local floor = Platform:new(0, 768-50, 1024, 50)
  local left_wall = Platform:new(-100, 0, 100, 768)
  local right_wall = Platform:new(1024, 0, 100, 768)
  local ceiling = Platform:new(0, -100, 1024, 100)

  FloatyPlatform:new(400, 400)
end)
