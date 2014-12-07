local m = knight.module("Game")
m.require({"event"}, function(event)
  local World = class("World")

  function World:initialize()
    self.world =  love.physics.newWorld(0, 9.81 * love.physics.getMeter())
    love.physics.setMeter(64)
    self.world:setCallbacks(
      function(a, b, contact) self:startContact(a, b, contact) end,
      function(a, b, contact) self:endContact  (a, b, contact) end,
      function(a, b, contact) self:preSolve    (a, b, contact) end,
      function(a, b, contact) self:postSolve   (a, b, contact) end
    )
  end

  function World:startContact(a, b, contact)
    local a = a:getUserData()
    local b = b:getUserData()

    a:collide(b, contact)
    b:collide(a, contact)
  end

  function World:endContact(a, b, contact)
    local a = a:getUserData()
    local b = b:getUserData()

    a:uncollide(b, contact)
    b:uncollide(a, contact)
  end

  function World:preSolve(a, b, contact) end
  function World:postSolve(a, b, contact) end

  event:on("load", function()
    knight.module("Game").provide("world", World:new().world)
  end)
end)
m.require({"event", "world"}, function(event, world)
  event:on("update", function(dt)
    world:update(dt)
  end)
end)
