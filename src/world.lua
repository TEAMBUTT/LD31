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

    if (a:is_ground() and not b:is_ground()) or
       (b:is_ground() and not a:is_ground()) then
      local thing_on_ground

      if a:is_ground() then
        thing_on_ground = b
      else
        thing_on_ground = a
      end

      contact_x, contact_y = contact:getNormal()
      if contact_x == 0 and contact_y == 1 then
        thing_on_ground:set_on_ground(true)
      end
    end
  end

  function World:endContact(a, b, contact)
    local a = a:getUserData()
    local b = b:getUserData()

    if (a:is_ground() and not b:is_ground() and b:is_on_ground()) or
       (b:is_ground() and not a:is_ground() and a:is_on_ground()) then
      local thing_on_ground

      if a:is_ground() then
        thing_on_ground = b
      else
        thing_on_ground = a
      end

      contact_x, contact_y = contact:getNormal()
      if contact_x == 0 and contact_y == 1 then
        thing_on_ground:set_on_ground(false)
      end
    end
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
