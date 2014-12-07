knight
.module("Game")
.component("map",
{"event", "world", "palette", "Platform", "FloatyPlatform", "ScreenPiece"},
function(event, world, palette, Platform, FloatyPlatform, ScreenPiece)
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
    "                              *                                 ",
    "                                                                ",
    "              *                                                 ",
    "                                                                ",
    "                                                =               ",
    "                  =========================     =               ",
    "          ========                              =               ",
    "                                              ==                ",
    "    *                       *            =====                  ",
    "                                      ===                       ",
    "  ========                         ===                          ",
    "                                ===                             ",
    "                            ====                                ",
    "                        ====                                    ",
    "                                                                ",
    "                                  *                             ",
    "                  ====                                          ",
    "                       ====                                     ",
    "                            ====                                ",
    "                                ========                        ",
    "                                                                ",
    "                                        ==                      ",
    "                                                                ",
    "                                                                ",
    "                                              ===               ",
    "                                                                ",
    "                                                                ",
    "                                                   ===          ",
    "                                                                ",
    "                                                                ",
    "                                                         ===    ",
    "                                                                ",
    "                                                                ",
    "                                 *                 ==========   ",
    "         *                                                      ",
    "                                               ==               ",
    "                             ==========       =  =      *       ",
    "                     ==============================             ",
    "                                                                ",
    "                                                                ",
    "                                                                ",
    "                                                                "
  }

  local function scanrow(s, pattern, callback)
    local pos = 0
    while true do
      local start, fin = string.find(s, pattern, pos)
      if start == nil then break end
      callback(start-1, fin)
      pos = fin+1
    end
  end

  for i, s in ipairs(map) do
    local y = i-1
    scanrow(s, "=+", function(x1, x2)
      FloatyPlatform:new(x1, y, x2 - x1)
    end)
    scanrow(s, "%*", function(x, _)
      ScreenPiece:new(x*16, y*16)
    end)
  end

  -- Ensure I am not bad at counting
  assert(height/16 == #map)
  assert(1024/16 == string.len(map[1]))

end)
