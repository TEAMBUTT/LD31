knight.module("Game")
.component("AnimationCollection", {"images"}, function(images)
  local AnimationCollection = class('AnimationCollection')

  function AnimationCollection:initialize(image_table, width, height, speed)
    self.animations = {}
    for name, filename in pairs(image_table) do
      local image = images(filename)
      self.animations[name] = newAnimation(image, width, height, speed, 0)
      self.current_name = self.current_name or name
    end
  end

  function AnimationCollection:set(name)
    self.current_name = name
  end

  function AnimationCollection:current()
    return assert(self.animations[self.current_name])
  end

  function AnimationCollection:update(dt)
    self:current():update(dt)
  end

  function AnimationCollection:play(dt)
    self:current():play(dt)
  end

  function AnimationCollection:stop(dt)
    self:current():stop(dt)
  end

  function AnimationCollection:draw(x, y)
    self:current():draw(x, y)
  end

  return AnimationCollection
end)
