knight
.module("Game")
.component("FloatyPlatform", {"palette", "world", "Platform"}, function(palette, world, Platform)
  local FloatyPlatform = class("FloatyPlatform", Platform)

  function FloatyPlatform:initialize(x, y)
    Platform.initialize(self, x*16, y*16, 128, 16)
  end

  function FloatyPlatform:color() return palette.brown end

  return FloatyPlatform
end)
