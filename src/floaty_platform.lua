knight
.module("Game")
.component("FloatyPlatform", {"palette", "world", "Platform"}, function(palette, world, Platform)
  local FloatyPlatform = class("FloatyPlatform", Platform)

  function FloatyPlatform:initialize(x, y, width)
    Platform.initialize(self, x*8, y*8, width*8, 8)
  end

  function FloatyPlatform:color() return palette.brown end

  return FloatyPlatform
end)
