package.path = package.path .. ';./src/?.lua;./src/?/init.lua'
knight = require 'vendor.knight'
class = require 'vendor.middleclass'

-- Some global helper methods
inspect = require 'vendor.inspect'
function p(val)
  print(inspect(val))
end

require 'event'
require 'world'

knight.module("Game").component("ball", {"event", "world"}, function(event, world)
  local ball = {}
  ball.body = love.physics.newBody(world, 650/2, 650/2, "dynamic")
  ball.shape = love.physics.newCircleShape(20)
  ball.fixture = love.physics.newFixture(ball.body, ball.shape, 1)
  ball.fixture:setRestitution(0.9)

  event.on("draw", function(e)
    love.graphics.setColor(193, 47, 14)
    love.graphics.circle("fill", ball.body:getX(), ball.body:getY(), ball.shape:getRadius())
  end)

  event.on("update", function (dt)
    if love.keyboard.isDown("right") then
      ball.body:applyForce(400, 0)
    elseif love.keyboard.isDown("left") then
      ball.body:applyForce(-400, 0)
    elseif love.keyboard.isDown("up") then
      ball.body:setPosition(650/2, 650/2)
    end
  end)
end)

knight.module("Game").component("map", {"event", "world"}, function(event, world)
  -- just a piece of ground for now
  local ground = {}
  ground.body = love.physics.newBody(world, 650/2, 650-50/2)
  ground.shape = love.physics.newRectangleShape(650, 50)
  ground.fixture = love.physics.newFixture(ground.body, ground.shape)

  event.on("draw", function(e)
    love.graphics.setColor(72, 160, 14)
    love.graphics.polygon("fill", ground.body:getWorldPoints(ground.shape:getPoints()))
  end)
end)

knight.module("Game").component("misc_objects", {"event", "world"}, function(event, world)
  local block1 = {}
  block1.body = love.physics.newBody(world, 200, 550, "dynamic")
  block1.shape = love.physics.newRectangleShape(0, 0, 50, 100)
  block1.fixture = love.physics.newFixture(block1.body, block1.shape, 5) -- A higher density gives it more mass.

  local block2 = {}
  block2.body = love.physics.newBody(world, 200, 400, "dynamic")
  block2.shape = love.physics.newRectangleShape(0, 0, 100, 50)
  block2.fixture = love.physics.newFixture(block2.body, block2.shape, 2)

  event.on("draw", function(e)
    love.graphics.setColor(50, 50, 50)
    love.graphics.polygon("fill", block1.body:getWorldPoints(block1.shape:getPoints()))
    love.graphics.polygon("fill", block2.body:getWorldPoints(block2.shape:getPoints()))
  end)
end)

knight.module("Game").require({"event"}, function(event)
  function love.load()
    love.graphics.setBackgroundColor(104, 136, 248)
    love.window.setMode(650, 650)
    event.trigger("load")
  end

  function love.draw()
    event.trigger("draw")
  end

  function love.update(dt)
    event.trigger("update", dt)
  end

  function love.keypressed(key)
    event.trigger("keypressed", key)
  end

  function love.keyreleased(key)
    event.trigger("keyreleased", key)
  end

  function love.mousepressed(x, y, button)
    event.trigger("mousepressed", x, y, button)
  end

  function love.mousereleased(x, y, button)
    event.trigger("mousereleased", x, y, button)
  end

  function love.focus(focus)
    event.trigger("focus", focus)
  end

  function love.quit()
    event.trigger("quit")
  end
end)

