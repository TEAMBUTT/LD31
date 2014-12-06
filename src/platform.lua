knight
.module("Game")
.component("Platform", {"event", "world", "palette"}, function(event, world, palette)
  local Platform = class("Platform")

  function Platform:initialize(x, y, w, h)
    self.body = love.physics.newBody(world, x, y)
    self.shape = love.physics.newRectangleShape(w/2, h/2, w, h, 0)
    self.fixture = love.physics.newFixture(self.body, self.shape)

    event:on("update", function(dt) self:update(dt) end)
    event:on("draw", function(e) self:draw(e) end)
  end

  function Platform:draw(e)
    love.graphics.setColor(unpack(self:color()))
    love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
  end

  function Platform:update(dt)
  end

  function Platform:color() return palette.green end

  return Platform
end)
