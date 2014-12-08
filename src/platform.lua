knight
.module("Game")
.component("Platform", {"Entity", "world", "palette"}, function(Entity, world, palette)
  local Platform = class("Platform", Entity)

  function Platform:initialize(x, y, w, h)
    Entity.initialize(self)
    self.body = love.physics.newBody(world, x, y)
    self.shape = self:build_shape(w, h)
    self.fixture = love.physics.newFixture(self.body, self.shape)
    self.fixture:setCategory(FixtureCategory.wall)
    self.fixture:setUserData(self)

    self:on("update", function(dt) self:update(dt) end)
    self:on("draw", function(e) self:draw(e) end)
  end

  function Platform:build_shape(w, h)
    return love.physics.newRectangleShape(w/2, h/2, w, h)
  end

  function Platform:draw(e)
    love.graphics.setColor(unpack(self:color()))
    love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
  end

  function Platform:update(dt)
  end

  function Platform:color() return palette.green end

  function Platform:is_ground()
    return true
  end

  return Platform
end)
