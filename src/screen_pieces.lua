knight
.module("Game")
.component("screen_pieces",
{"Entity", "world", "palette"},
function(Entity, world, palette)
  local shape_coordinates = _.map({
    0, 1,
    1, 0,
    2, 1,
    2, 2,
    1, 3,
    0, 2
  }, function(x) return x * 6 end)

  local ScreenPiece = class("ScreenPiece", Entity)

  function ScreenPiece:initialize(n)
    self.piece_number = n or 1

    Entity.initialize(self)

    self.body = love.physics.newBody(world, 50, 50, "dynamic")
    self.body:setFixedRotation(true)
    self.body:setLinearDamping(1)

    self.shape = love.physics.newPolygonShape(unpack(shape_coordinates))

    self.fixture = love.physics.newFixture(self.body, self.shape, 1)
    self.fixture:setUserData(self)

    self:bind_events()
  end

  function ScreenPiece:bind_events()
    self:on("update", function(dt) self:update(dt) end)
    self:on("draw", function() self:draw() end)
  end

  function ScreenPiece:update(dt)
  end

  function ScreenPiece:draw()
    love.graphics.setColor(unpack(palette.violet))
    love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))
  end

  ScreenPiece:new()
end)
