knight
.module("Game")
.component("ScreenPiece",
{"Entity", "world", "palette", "event", "AnimationCollection"},
function(Entity, world, palette, event, AnimationCollection)
  local shape_coordinates = _.map({
    0, 1,
    1, 0,
    2, 1,
    2, 2,
    1, 3,
    0, 2
  }, function(x) return x * 4 end)

  local ScreenPiece = class("ScreenPiece", Entity)

  ScreenPiece.total = 0
  ScreenPiece.collected = 0

  event:on("piece_collected", function(collected, total)
    if collected == total then
      event:trigger("victory")
    end
  end)

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
      self.body:destroy()
    end)

    self.anim = AnimationCollection:new({
      spin="screen_piece.png"
    }, 16, 16, 0.05)

    self:bind_events()
  end

  function ScreenPiece:bind_events()
    self:on("update", function(dt) self:update(dt) end)
    self:on("draw", function() self:draw() end)
    self:on("startContact", function(...) self:contact(...) end)
  end

  function ScreenPiece:contact(other, contact)
    if other.class.name == "Player" then
      ScreenPiece.collected = ScreenPiece.collected + 1
      event:trigger("piece_collected", ScreenPiece.collected, ScreenPiece.total)
      self:destroy()
    end
  end

  function ScreenPiece:update(dt)
    self.anim:update(dt)
    self.anim:play()
  end

  function ScreenPiece:draw()
    local x, y = self.body:getWorldCenter()
    love.graphics.setColor(unpack(palette.lightblue))
    self.anim:draw(math.floor(x-8), math.floor(y-9))
  end

  return ScreenPiece
end)
