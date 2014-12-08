knight.module("Game")
.component("Puff",
{"Entity", "world", "event", "palette"},
function(Entity, world, event, palette)
  local Puff = class("Puff", Entity)

  function Puff:initialize(x, y, direction)
    Entity.initialize(self)

    self.body = love.physics.newBody(world, x, y, "dynamic")
    -- self.body:setLinearDamping(10)

    self.shape = love.physics.newCircleShape(1)

    self.fixture = love.physics.newFixture(self.body, self.shape, 1)
    self.fixture:setCategory(FixtureCategory.effect)
    self.fixture:setMask(unpack(_.reject(_.values(FixtureCategory), function(category)
      return category == FixtureCategory.wall
    end)))

    local vx = 30
    local vy = -15
    if direction == "right" then
      self.body:setLinearVelocity(vx, vy)
    elseif direction == "left" then
      self.body:setLinearVelocity(-vx, vy)
    else
      local r = love.math.random
      self.body:setLinearVelocity(r(-40, 40), r(-30, 0))
    end

    self.animation = {
      opacity = 255,
      size = 1
    }
    self.opacity_tween = tween.new(0.20, self.animation, {
      opacity = 0,
      size = 5.5
    }, tween.easing.inOutQuad)

    self:bind_events()
  end

  function Puff:bind_events()
    self:on("update", function(dt) self:update(dt) end)
    self:on("draw", function(e) self:draw(e) end)
    self:on("destroy", function() self.body:destroy() end)
  end

  function Puff:update(dt)
    if self.opacity_tween:update(dt) then
      self:destroy()
    end
    self.shape:setRadius(self.animation.size)
  end

  function Puff:draw(e)
    local x, y = self.body:getWorldCenter()
    local r, g, b = unpack(palette.white)
    love.graphics.setColor(r, g, b, self.animation.opacity)
    love.graphics.circle("fill", self.body:getX(), self.body:getY(), self.shape:getRadius())
  end

  return Puff
end)
