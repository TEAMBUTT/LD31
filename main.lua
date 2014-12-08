knight = require 'vendor.knight'
class = require 'vendor.middleclass'
_ = require 'vendor.underscore'
require 'vendor.AnAL'
tween = require 'vendor.tween'

-- Some global helper methods
inspect = require 'vendor.inspect'
function p(val)
  print(inspect(val))
end

FixtureCategory = {
  player = 1,
  feet = 2,
  bad_guy = 3,
  piece = 4,
  wall = 5,
  ghost_wall = 6
}

require 'src.event_listener'
require 'src.event'
require 'src.world'
require 'src.palette'
require 'src.player'
require 'src.entity'
require 'src.map'
require 'src.platform'
require 'src.floaty_platform'
require 'src.badguy'
require 'src.screen_pieces'
require 'src.images'
require 'src.animation_collection'
require 'src.feet'
require 'src.darkness'
require 'src.text'
require 'src.slope'
require 'src.window'
require 'src.audio'
require 'src.ghost_wall'

local width, height = 512, 376
local scale = 2

knight.module("Game").require({"event", "palette"}, function(event, palette)
  function love.load()
    love.graphics.setBackgroundColor(unpack(palette.black))
    love.window.setMode(width*scale, height*scale)
    love.graphics.setDefaultFilter('nearest', 'nearest', 1)
    event:trigger("load")
  end

  function love.draw()
    love.graphics.scale(scale, scale)
    event:trigger("draw_stencil")

    love.graphics.setColor(palette.grey1)
    love.graphics.rectangle("fill", 0, 0, width, height)

    event:trigger("draw")

    love.graphics.setStencil()

    event:trigger("draw_overlay")
  end

  function love.update(dt)
    event:trigger("update", dt)
  end

  function love.keypressed(key)
    event:trigger("keypressed", key)
  end

  function love.keyreleased(key)
    event:trigger("keyreleased", key)
    if key == 'escape' then love.event.quit() end
  end

  function love.mousepressed(x, y, button)
    event:trigger("mousepressed", x, y, button)
  end

  function love.mousereleased(x, y, button)
    event:trigger("mousereleased", x, y, button)
  end

  function love.focus(focus)
    event:trigger("focus", focus)
  end

  function love.quit()
    event:trigger("quit")
  end
end)

