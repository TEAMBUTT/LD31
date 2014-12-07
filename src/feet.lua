local m = knight.module("Game")
m.component("Feet", {"Entity"}, function(Entity)
  local Feet = class("Feet", Entity)

  function Feet:initialize(fixture, body)
    Entity.initialize(self)
    local topLeftX, topLeftY, bottomRightX, bottomRightY = fixture:getBoundingBox()

    local y = bottomRightY
    local x = (topLeftX + bottomRightX) / 2

    -- fixme: hardcoded to player
    self.shape = love.physics.newRectangleShape(8, 32, 10, 10)
    self.fixture = love.physics.newFixture(body, self.shape)
    self.fixture:setSensor(true)

    self.fixture:setUserData(self)

    self.contacts = {}

    self:on("startContact", function(other, contact)
      table.insert(self.contacts, other)
    end)
    self:on("endContact", function(other, contact)
      self.contacts = _.reject(self.contacts, function(o)
        return o == other
      end)
    end)
  end

  function Feet:on_ground()
    return not not next(self.contacts)
  end

  return Feet
end)
