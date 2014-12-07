knight.module("Game")
.component("BadGuy", {"world", "Entity", "palette", "player", "AnimationCollection", "darkness"}, function(world, Entity, palette, player, AnimationCollection, darkness)
  local shape_coordinates = _.map({
    0, 1,
    2, 1,
    2, 3,
    1, 4,
    0, 3
  }, function(x) return x * 4 end)

  local BadGuy = class("BadGuy", Entity)

  function BadGuy:initialize(x, y)
    Entity.initialize(self)
    self.body = love.physics.newBody(world, x, y, "dynamic")
    self.body:setFixedRotation(true)
    self.body:setLinearDamping(1)
    self.shape = love.physics.newPolygonShape(unpack(shape_coordinates))
    self.fixture = love.physics.newFixture(self.body, self.shape, 1)
    self.fixture:setUserData(self)

    --self.anim = newAnimation(image, 32, 32, 0.1, 0)
    self.anim = AnimationCollection:new({
      left="muncher_left.png",
      right="muncher_right.png"
    }, 16, 16, 0.2)
    self:on("destroy", function() self.body:destroy() end)

    self:bind_events()
  end

  function BadGuy:bind_events()
    self:on("update", function(dt) self:update(dt) end)
    self:on("draw", function(e) self:draw(e) end)
    self:on("startContact", function(other, contact)
      self:start_contact(other, contact)
    end)
  end

  function BadGuy:update(dt)
    self.anim:update(dt)

    distance, x1, y1, x2, y2 = love.physics.getDistance(player.fixture, self.fixture)
    if distance <= darkness.radius then
      if x1 < x2 then
        self.anim:set("left")
        self.body:applyForce(-5, 0)
      else
        self.anim:set("right")
        self.body:applyForce(5, 0)
      end
    end
  end

  function BadGuy:draw(e)
    love.graphics.setColor(unpack(palette.lightred))
    local x, y = self.body:getWorldCenter()
    self.anim:draw(math.floor(x-8), math.floor(y-8))
  end

  function BadGuy:start_contact(other, contact)
    if other.class.name == "Player" then
      other:bump({contact:getNormal()})
    end
  end

  return BadGuy
end)
