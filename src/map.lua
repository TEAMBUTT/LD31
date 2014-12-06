knight
.module("Game")
.component("map", {"event", "world", "palette"}, function(event, world, palette)
  -- just a piece of ground for now
  local ground = {}
  ground.body = love.physics.newBody(world, 1024/2, 768-50/2)
  ground.shape = love.physics.newRectangleShape(1024, 50)
  ground.fixture = love.physics.newFixture(ground.body, ground.shape)

  event.on("draw", function(e)
    love.graphics.setColor(unpack(palette.green))
    love.graphics.polygon("fill", ground.body:getWorldPoints(ground.shape:getPoints()))
  end)
end)
