knight.module("Game")
.component("GhostWall", {"world", "Entity", "FloatyPlatform"}, function(world, Entity, FloatyPlatform)
  local GhostWall = class("GhostWall", FloatyPlatform)

  function GhostWall:initialize(x, y, width)
    FloatyPlatform.initialize(self, x, y, width)
    self.fixture:setCategory(FixtureCategory.ghost_wall)
    self.fixture:setMask(FixtureCategory.player, FixtureCategory.feet)
  end

  function GhostWall:draw()
  end

  return GhostWall
end)
