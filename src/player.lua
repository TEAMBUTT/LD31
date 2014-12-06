knight.module("Game")
.component("player", {"event", "world"}, function(event, world)
  local Player = class('Player')

  function Player:initialize()
    self.body = love.physics.newBody(world, 640/3, 640/3, "dynamic")
    self.shape = love.physics.newPolygonShape(
      0, 1,
      2, 0,
      4, 1,
      4, 6,
      2, 7,
      0, 6
    )
    self.fixture = love.physics.newFixture(self.body, self.shape, 1)
    self:bind_events()
  end

  function Player:bind_events()
    event.on("update", function(dt) self:update(dt) end)
    event.on("draw", function(e) self:draw(e) end)
  end

  function Player:update(dt)
  end

  function Player:draw(e)
  end

  return Player:new()
end)
