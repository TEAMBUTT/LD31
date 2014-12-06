knight
.module("Game")
.component("Platform", {"event", "world", "palette"}, function(event, world, palette)
  local Platform = class("Platform")

  function Platform:initialize(x, y, w, h)
    self.body = love.physics.newBody(world, x, y)
    self.shape = love.physics.newRectangleShape(w/2, h/2, w, h, 0)
    self.fixture = love.physics.newFixture(self.body, self.shape)

    event.on("draw", function(e)
      love.graphics.setColor(unpack(palette.green))
      love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
    end)
  end

  return Platform
end)
