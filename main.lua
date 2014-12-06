package.path = package.path .. ';./src/?.lua;./src/?/init.lua'
knight = require 'vendor.knight'
class = require 'vendor.middleclass'
_ = require 'vendor.underscore'
require 'vendor.AnAL'

-- Some global helper methods
inspect = require 'vendor.inspect'
function p(val)
  print(inspect(val))
end

require 'event'
require 'world'
require 'palette'
require 'player'
require 'entity'

knight.module("Game").component("ball", {"event", "world", "palette"}, function(event, world, palette)
  local ball = {}
  ball.body = love.physics.newBody(world, 1024/2, 768/2, "dynamic")
  ball.shape = love.physics.newCircleShape(20)
  ball.fixture = love.physics.newFixture(ball.body, ball.shape, 1)
  ball.fixture:setRestitution(0.9)

  event.on("draw", function(e)
    love.graphics.setColor(unpack(palette.lightred))
    love.graphics.circle("fill", ball.body:getX(), ball.body:getY(), ball.shape:getRadius())
  end)

  event.on("update", function (dt)
    if love.keyboard.isDown("right") then
      ball.body:applyForce(400, 0)
    elseif love.keyboard.isDown("left") then
      ball.body:applyForce(-400, 0)
    elseif love.keyboard.isDown("up") then
      ball.body:setPosition(1024/2, 768/2)
    end
  end)
end)

knight.module("Game").component("map", {"event", "world", "palette"}, function(event, world, palette)
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

knight.module("Game").component("misc_objects", {"event", "world", "palette"}, function(event, world, palette)
  local block1 = {}
  block1.body = love.physics.newBody(world, 200, 550, "dynamic")
  block1.shape = love.physics.newRectangleShape(0, 0, 10, 100)
  block1.fixture = love.physics.newFixture(block1.body, block1.shape, 5) -- A higher density gives it more mass.

  local block2 = {}
  block2.body = love.physics.newBody(world, 200, 400, "dynamic")
  block2.shape = love.physics.newRectangleShape(0, 0, 100, 10)
  block2.fixture = love.physics.newFixture(block2.body, block2.shape, 2)

  event.on("draw", function(e)
    love.graphics.setColor(unpack(palette.grey1))
    love.graphics.polygon("fill", block1.body:getWorldPoints(block1.shape:getPoints()))
    love.graphics.polygon("fill", block2.body:getWorldPoints(block2.shape:getPoints()))
  end)
end)

knight.module("Game").require({"event", "palette"}, function(event, palette)
  function love.load()
    love.graphics.setBackgroundColor(unpack(palette.cyan))
    love.window.setMode(1024, 768)
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
    if key == 'escape' then love.event.quit() end
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

