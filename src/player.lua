knight.module("Game")
.component("player", {"event", "world", "palette"}, function(event, world, palette)
  local Player = class('Player')

  local shape_coordinates = _.map({
    0, 1,
    1, 0,
    2, 1,
    2, 3,
    1, 4,
    0, 3
  }, function(x) return x * 8 end)

  function Player:initialize()
    self.body = love.physics.newBody(world, 640/3, 640/3, "dynamic")
    self.body:setFixedRotation(true)
    self.shape = love.physics.newPolygonShape(unpack(shape_coordinates))
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
    love.graphics.setColor(unpack(palette.violet))
    love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))
  end

  return Player:new()
end)
