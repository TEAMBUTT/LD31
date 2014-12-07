knight
.module("Game")
.component("ScreenPiece",
{"Entity", "world", "palette", "player", "event"},
function(Entity, world, palette, player, event)
  local shape_coordinates = _.map({
    0, 1,
    1, 0,
    2, 1,
    2, 2,
    1, 3,
    0, 2
  }, function(x) return x * 6 end)

  local ScreenPiece = class("ScreenPiece", Entity)

  ScreenPiece.total = 0
  ScreenPiece.collected = 0

  function ScreenPiece:initialize(x, y)
    ScreenPiece.total = ScreenPiece.total + 1

    Entity.initialize(self)

    self.body = love.physics.newBody(world, x, y, "dynamic")
    self.body:setFixedRotation(true)
    self.body:setLinearDamping(1)

    self.shape = love.physics.newPolygonShape(unpack(shape_coordinates))

    self.fixture = love.physics.newFixture(self.body, self.shape, 1)
    self.fixture:setUserData(self)
    self:on("destroy", function()
      self.fixture:destroy()
      self.body:destroy()
    end)

    self:bind_events()
  end

  function ScreenPiece:bind_events()
    self:on("update", function(dt) self:update(dt) end)
    self:on("draw", function() self:draw() end)
    self:on("startContact", function(...) self:contact(...) end)
  end

  function ScreenPiece:contact(other, contact)
    if other == player then
      ScreenPiece.collected = ScreenPiece.collected + 1
      event:trigger("piece_collected", ScreenPiece.collected)
      print("" .. ScreenPiece.collected .. " of " .. ScreenPiece.total .. " pieces collected")
      self:destroy()
    end
  end

  function ScreenPiece:update(dt)
  end

  function ScreenPiece:draw()
    love.graphics.setColor(unpack(palette.violet))
    love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))
  end

  return ScreenPiece
end)
