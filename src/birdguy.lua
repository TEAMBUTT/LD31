knight.module("Game")
.component("BirdGuy", {"event", "world", "Entity", "palette", "player", "AnimationCollection", "darkness"}, function(event, world, Entity, palette, player, AnimationCollection, darkness)
  local shape_coordinates = _.map({
    0, 1,
    2, 1,
    2, 3,
    1, 4,
    0, 3
  }, function(x) return x * 4 end)

  local BirdGuy = class("BirdGuy", Entity)

  function BirdGuy:initialize(x, y)
    Entity.initialize(self)
    self.body = love.physics.newBody(world, x, y, "dynamic")
    self.body:setFixedRotation(true)
    self.body:setLinearDamping(5)
    self.body:setGravityScale(0)
    self.shape = love.physics.newPolygonShape(unpack(shape_coordinates))
    self.fixture = love.physics.newFixture(self.body, self.shape, 1)
    self.fixture:setCategory(FixtureCategory.bad_guy)
    self.fixture:setUserData(self)

    --self.anim = newAnimation(image, 32, 32, 0.1, 0)
    self.anim = AnimationCollection:new({
      left="bird_left.png",
      right="bird_right.png"
    }, 16, 16, 0.2)
    self:on("destroy", function() self.body:destroy() end)

    self:bind_events()
    self.dx = 0
  end

  function BirdGuy:bind_events()
    self:on("update", function(dt) self:update(dt) end)
    self:on("draw", function(e) self:draw(e) end)
    self:on("startContact", function(other, contact)
      self:start_contact(other, contact)
    end)
  end

  function BirdGuy:update(dt)
    self.dx = self.dx + dt
    self.anim:update(dt)

    distance, x1, y1, x2, y2 = love.physics.getDistance(player.fixture, self.fixture)

    local dt = 1
    if self.dx > dt then
      self.dx = self.dx - dt

      if distance <= darkness.radius * 2 then
        local v = 200

        if x1 < x2 then
          self.anim:set("left")
          self.body:applyForce(-v, 0)
        else
          self.anim:set("right")
          self.body:applyForce(v, 0)
        end

        if y1 < y2 then
          self.anim:set("left")
          self.body:applyForce(0, -v)
        else
          self.anim:set("right")
          self.body:applyForce(0, v)
        end
      end
    end
  end

  function BirdGuy:draw(e)
    love.graphics.setColor(unpack(palette.lightred))
    local x, y = self.body:getWorldCenter()
    self.anim:draw(math.floor(x-8), math.floor(y-8))
  end

  function BirdGuy:start_contact(other, contact)
    if other.class.name == "Player" then
      other:bump({contact:getNormal()})
      event:trigger("bump")
    end
  end

  return BirdGuy
end)
