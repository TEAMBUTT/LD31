package.path = package.path .. ';./src/?/init.lua'
require 'vendor.knight'

foo = {1,2,3}
foo = {1,2,3, foo="bar", bar="baz" }

function love.load()
  love.graphics.setBackgroundColor(104, 136, 248)
  --love.window.setMode(1024, 1024)

  love.physics.setMeter(64)
  world = love.physics.newWorld(0, 9.81 * love.physics.getMeter())

  --let's create the ground
  ground = {}
  ground.body = love.physics.newBody(world, 650/2, 650-50/2)
  ground.shape = love.physics.newRectangleShape(650, 50)
  ground.fixture = love.physics.newFixture(ground.body, ground.shape)

  --let's create a ball
  ball = {}
  ball.body = love.physics.newBody(world, 650/2, 650/2, "dynamic") --place the body in the center of the world and make it dynamic, so it can move around
  ball.shape = love.physics.newCircleShape(20) --the ball's shape has a radius of 20
  ball.fixture = love.physics.newFixture(ball.body, ball.shape, 1) -- Attach fixture to body and give it a density of 1.
  ball.fixture:setRestitution(0.9) --let the ball bounce

  --let's create a couple blocks to play around with
  block1 = {}
  block1.body = love.physics.newBody(world, 200, 550, "dynamic")
  block1.shape = love.physics.newRectangleShape(0, 0, 50, 100)
  block1.fixture = love.physics.newFixture(block1.body, block1.shape, 5) -- A higher density gives it more mass.

  block2 = {}
  block2.body = love.physics.newBody(world, 200, 400, "dynamic")
  block2.shape = love.physics.newRectangleShape(0, 0, 100, 50)
  block2.fixture = love.physics.newFixture(block2.body, block2.shape, 2)

  love.window.setMode(650, 650)
end

function love.update(dt)
  world:update(dt)

  --here we are going to create some keyboard events
  if love.keyboard.isDown("right") then --press the right arrow key to push the ball to the right
    ball.body:applyForce(400, 0)
  elseif love.keyboard.isDown("left") then --press the left arrow key to push the ball to the left
    ball.body:applyForce(-400, 0)
  elseif love.keyboard.isDown("up") then --press the up arrow key to set the ball in the air
    ball.body:setPosition(650/2, 650/2)
  end
end

function love.draw()
  love.graphics.setColor(72, 160, 14)
  love.graphics.polygon("fill", ground.body:getWorldPoints(ground.shape:getPoints()))

  love.graphics.setColor(193, 47, 14)
  love.graphics.circle("fill", ball.body:getX(), ball.body:getY(), ball.shape:getRadius())

  love.graphics.setColor(50, 50, 50)
  love.graphics.polygon("fill", block1.body:getWorldPoints(block1.shape:getPoints()))
  love.graphics.polygon("fill", block2.body:getWorldPoints(block2.shape:getPoints()))
end

function love.keypressed(key)
end

function love.keyreleased(key)
end

function love.mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
end

function love.focus(focus)
end

function love.quit()
end

