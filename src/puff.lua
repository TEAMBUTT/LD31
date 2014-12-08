knight.module("Game")
.component("Puff",
{"Entity", "world", "event", "palette"},
function(Entity, world, event, palette)
  local Puff = class("Puff", Entity)

  function Puff:initialize(x, y, direction)
    Entity.initialize(self)
    p({x, y, direction})

    self.body = love.physics.newBody(world, x, y, "dynamic")
    -- self.body:setLinearDamping(10)

    self.shape = love.physics.newCircleShape(2.5)

    self.fixture = love.physics.newFixture(self.body, self.shape, 1)
    self.fixture:setCategory(FixtureCategory.effect)
    self.fixture:setMask(unpack(_.reject(_.values(FixtureCategory), function(category)
      return category == FixtureCategory.wall
    end)))

    local vx = 100
    local vy = -30
    if direction == "right" then
      self.body:setLinearVelocity(vx, vy)
    else
      self.body:setLinearVelocity(-vx, vy)
    end

    self:bind_events()
  end

  function Puff:bind_events()
    event:on("update", function(dt) self:update(dt) end)
    event:on("draw", function(e) self:draw(e) end)
  end

  function Puff:update(dt)
  end

  function Puff:draw(e)
    local x, y = self.body:getWorldCenter()
    love.graphics.setColor(unpack(palette.white))
    love.graphics.circle("fill", self.body:getX(), self.body:getY(), self.shape:getRadius())
  end

  return Puff
end)
