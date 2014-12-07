knight
.module("Game")
.component("map",
{"event", "world", "palette", "Platform", "FloatyPlatform"},
function(event, world, palette, Platform, FloatyPlatform)
  local width, height = 1024, love.graphics.getHeight()

  local floor = Platform:new(0, height - 32, 1024, 32)
  local left_wall = Platform:new(-100, 0, 100, height)
  local right_wall = Platform:new(1024, 0, 100, height)
  local ceiling = Platform:new(0, -100, 1024, 100)

  local map = {
    "                                                                ",
    "                                                                ",
    "                                                                ",
    "                                                                ",
    "                                                                ",
    "                                                                ",
    "                                                                ",
    "                                                                ",
    "                                                                ",
    "                                                                ",
    "                                                                ",
    "          ========                                              ",
    "                                                                ",
    "                                                                ",
    "                                                                ",
    "  ========                                                      ",
    "                                                                ",
    "                                                                ",
    "                                                                ",
    "                                                                ",
    "                                                                ",
    "                                                                ",
    "                                                                ",
    "                                                                ",
    "                                ========                        ",
    "                                                                ",
    "                                                                ",
    "                                                                ",
    "                                                                ",
    "                                                                ",
    "                                                                ",
    "                                                                ",
    "                                                                ",
    "                                                                ",
    "                                                                ",
    "                                                                ",
    "                                                                ",
    "                                                                ",
    "                                                   ============ ",
    "                                                                ",
    "                                               ==               ",
    "                             ==========       =  =              ",
    "                     ========          =======    =             ",
    "                                                                ",
    "                                                                ",
    "                                                                ",
    "                                                                "
  }

  for y, s in ipairs(map) do
    local pos = 0
    while true do
      local start, fin = string.find(s, "=+", pos)
      if start == nil then break end
      FloatyPlatform:new(start-1, y-1, fin - start + 1)
      pos = fin+1
    end
  end

  -- Ensure I am not bad at counting
  assert(height/16 == #map)
  assert(1024/16 == string.len(map[1]))

end)
