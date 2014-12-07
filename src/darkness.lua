knight.module("Game")
.component("darkness", {"player", "event", "ScreenPiece"}, function(player, event, ScreenPiece)
  local darkness = {}

  local function desired_radius(collected)
    return 30 + (15 * collected)
  end

  -- sentinel null-tweens
  darkness.radius = desired_radius(0)
  local t = tween.new(1, darkness, {}, tween.easing.linear)
  event:on("update", function(dt) t:update(dt) end)

  event:on("piece_collected", function(count)
    t = tween.new(2, darkness, {radius=desired_radius(count)}, tween.easing.inOutQuad)
  end)

  local darkness_stencil = function()
    local x, y = player.body:getWorldCenter()
    local radius = darkness.radius
    love.graphics.circle("fill", x, y, radius, radius)
  end

  event:on("draw_stencil", function()
    love.graphics.setStencil(darkness_stencil)
  end)

  return darkness
end)
