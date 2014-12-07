package.path = package.path .. ';./src/?.lua;./src/?/init.lua'
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

require 'event_listener'
require 'event'
require 'world'
require 'palette'
require 'player'
require 'entity'
require 'map'
require 'platform'
require 'floaty_platform'
require 'badguy'
require 'screen_pieces'
require 'images'
require 'animation_collection'
require 'feet'
require 'darkness'

local width, height = 1024, 752

knight.module("Game").require({"event", "palette"}, function(event, palette)
  function love.load()
    love.graphics.setBackgroundColor(unpack(palette.black))
    love.window.setMode(width, height)
    event:trigger("load")
  end

  function love.draw()
    event:trigger("draw_stencil")

    love.graphics.setColor(palette.grey1)
    love.graphics.rectangle("fill", 0, 0, width, height)

    event:trigger("draw")
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

