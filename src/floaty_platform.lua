knight
.module("Game")
.component("FloatyPlatform", {"palette", "world", "Platform"}, function(palette, world, Platform)
  local FloatyPlatform = class("FloatyPlatform", Platform)

  function FloatyPlatform:initialize(x, y, width)
    Platform.initialize(self, x*16, y*16, width*16, 16)
  end

  function FloatyPlatform:color() return palette.brown end

  return FloatyPlatform
end)
