knight
.module("Game")
.component("LeftSlope", {"palette", "FloatyPlatform"}, function(palette, FloatyPlatform)
  local LeftSlope = class("LeftSlope", FloatyPlatform)

  function LeftSlope:build_shape(w, h)
    return love.physics.newPolygonShape(0,h, w,0, w,h)
  end

  return LeftSlope
end)
.component("RightSlope", {"palette", "FloatyPlatform"}, function(palette, FloatyPlatform)
  local RightSlope = class("LeftSlope", FloatyPlatform)

  function RightSlope:build_shape(w, h)
    return love.physics.newPolygonShape(w,h, 0,0, 0,h)
  end

  return RightSlope
end)
