knight
.module("Game")
.component("ball", {"event", "world", "palette"}, function(event, world, palette)
  local ball = {}
  ball.body = love.physics.newBody(world, 3*1024/4, 768/2, "dynamic")
  ball.shape = love.physics.newCircleShape(20)
  ball.fixture = love.physics.newFixture(ball.body, ball.shape, 1)
  ball.fixture:setRestitution(0.9)

  event.on("draw", function(e)
    love.graphics.setColor(unpack(palette.lightred))
    love.graphics.circle("fill", ball.body:getX(), ball.body:getY(), ball.shape:getRadius())
  end)
end)
