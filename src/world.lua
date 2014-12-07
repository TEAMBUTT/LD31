local m = knight.module("Game")
m.require({"event"}, function(event)
  local World = class("World")

  function World:initialize()
    self.world = love.physics.newWorld(0, 9.81 * love.physics.getMeter())
    love.physics.setMeter(64)
    self.world:setCallbacks(
      function(a, b, contact) self:handleCallback("startContact", a, b, contact) end,
      function(a, b, contact) self:handleCallback("endContact",   a, b, contact) end,
      function(a, b, contact) self:handleCallback("preSolve",     a, b, contact) end,
      function(a, b, contact) self:handleCallback("postSolve",    a, b, contact) end
    )
  end

  function World:handleCallback(callback, a, b, contact)
    local delegate = function(target, other)
      if target and target.trigger and other then
        target:trigger(callback, other, contact)
      end
    end

    a = a:getUserData()
    b = b:getUserData()

    delegate(a, b)
    delegate(b, a)
  end


  event:on("load", function()
    knight.module("Game").provide("world", World:new().world)
  end)
end)
m.require({"event", "world"}, function(event, world)
  event:on("update", function(dt)
    world:update(dt)
  end)
end)
