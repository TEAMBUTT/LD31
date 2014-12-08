knight.module("Game")
.component("player", {"event", "world", "palette", "Entity", "AnimationCollection", "Feet"}, function(event, world, palette, Entity, AnimationCollection, Feet)
  local Player = class('Player', Entity)

  local shape_coordinates = _.map({
    0, 1,
    1, 0.75,
    2, 1,
    2, 3,
    1, 4,
    0, 3
  }, function(x) return x * 4 end)

  function Player:initialize()
    Entity.initialize(self)
    self.body = love.physics.newBody(world, 640/3, 640/3, "dynamic")
    self.body:setFixedRotation(true)
    self.body:setLinearDamping(1)

    self.shape = love.physics.newPolygonShape(unpack(shape_coordinates))
    self.direction = "left"

    self.fixture = love.physics.newFixture(self.body, self.shape, 1)
    self.fixture:setCategory(FixtureCategory.player)
    self.fixture:setUserData(self)

    self.feet = Feet:new(self.fixture, self.body)

    self.anim = AnimationCollection:new({
      left="player_left.png",
      right="player_right.png",
      jump_left="player_jump_left.png",
      jump_right="player_jump_right.png"
    }, 16, 16, 0.1)

    self:on("destroy", function() self.body:destroy() end)

    self:bind_events()
  end

  function Player:bind_events()
    event:on("update", function(dt) self:update(dt) end)
    event:on("draw", function(e) self:draw(e) end)
    event:on("keypressed", function(key) self:key_pressed(key) end)
  end

  function Player:update(dt)
    self.anim:update(dt)

    self.anim:play()
    if love.keyboard.isDown("right") then
      self.direction = "right"
      self.body:applyForce(15, 0)
    elseif love.keyboard.isDown("left") then
      self.direction = "left"
      self.body:applyForce(-15, 0)
    else
      self.anim:stop()
    end

    if self.feet:on_ground() then
      self.anim:set(self.direction)
    else
      self.anim:set("jump_" .. self.direction)
    end

    if love.keyboard.isDown("up") then
      self.body:applyForce(0, -5)
    end
  end

  function Player:draw(e)
    local x, y = self.body:getWorldCenter()
    love.graphics.setColor(unpack(palette.lightgreen))
    self.anim:draw(math.floor(x-8), math.floor(y-9))
  end

  function Player:key_pressed(key)
    if key == 'up' then
      self:jump()
    end
  end

  function Player:bump(normal)
    local scale = 6
    local x, y = unpack(normal)
    x = -x * scale
    y = -y * scale
    self.body:applyLinearImpulse(x, y)
  end

  function Player:jump()
    if self.feet:on_ground() then
      self.body:applyLinearImpulse(0, -6)
    end
  end

  return Player:new()
end)
