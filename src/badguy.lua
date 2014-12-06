knight.module("Game")
.component("BadGuy", {"event", "world", "palette", "Entity"}, function(event, world, palette, Entity)
  local shape_coordinates = _.map({
    0, 1,
    1, 0,
    2, 1,
    2, 3,
    1, 4,
    0, 3
  }, function(x) return x * 8 end)

  local BadGuy = class("BadGuy", Entity)

  local image = love.graphics.newImage("muncher.png")

  function BadGuy:initialize()
    Entity.initialize(self)
    self.body = love.physics.newBody(world, 640/2, 640/3, "dynamic")
    self.body:setFixedRotation(true)
    self.body:setLinearDamping(1)
    self.shape = love.physics.newPolygonShape(unpack(shape_coordinates))
    self.fixture = love.physics.newFixture(self.body, self.shape, 1)
    self.fixture:setUserData(self)

    self.anim = newAnimation(image, 32, 32, 0.1, 0)
    self:on("destroy", function() self.body:destroy() end)

    self:bind_events()
  end

  function BadGuy:bind_events()
    self:on("update", function(dt) self:update(dt) end)
    self:on("draw", function(e) self:draw(e) end)
  end

  function BadGuy:update(dt)
    self.anim:update(dt)
  end

  function BadGuy:draw(e)
    local x, y = self.body:getWorldCenter()
    self.anim:draw(x-16, y-16)
  end

  return BadGuy
end).component('badguy', {'BadGuy'}, function(BadGuy)
  return BadGuy:new()
end)
