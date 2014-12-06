knight
.module("Game")
.component("misc_objects", {"event", "world", "palette"}, function(event, world, palette)
  local block1 = {}
  block1.body = love.physics.newBody(world, 200, 550, "dynamic")
  block1.shape = love.physics.newRectangleShape(0, 0, 10, 100)
  block1.fixture = love.physics.newFixture(block1.body, block1.shape, 5) -- A higher density gives it more mass.

  local block2 = {}
  block2.body = love.physics.newBody(world, 200, 400, "dynamic")
  block2.shape = love.physics.newRectangleShape(0, 0, 100, 10)
  block2.fixture = love.physics.newFixture(block2.body, block2.shape, 2)

  event:on("draw", function(e)
    love.graphics.setColor(unpack(palette.grey1))
    love.graphics.polygon("fill", block1.body:getWorldPoints(block1.shape:getPoints()))
    love.graphics.polygon("fill", block2.body:getWorldPoints(block2.shape:getPoints()))
  end)
end)
