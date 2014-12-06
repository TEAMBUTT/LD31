knight
.module("Game")
.component("FloatyPlatform", {"palette", "world", "Platform"}, function(palette, world, Platform)
  local FloatyPlatform = class("FloatyPlatform", Platform)

  function FloatyPlatform:initialize(x, y)
    Platform.initialize(self, x, y, 100, 10)
  end

  function FloatyPlatform:color() return palette.brown end

  return FloatyPlatform
end)
