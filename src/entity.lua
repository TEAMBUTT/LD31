knight.module("Game")
.component("Entity", {"event", "EventListener"}, function(event, EventListener)
  local Entity = class('Entity')

  function Entity:initialize()
    -- wire up events
    self.events = EventListener:new()
    local subscription = function(n, e)
      self.events:trigger(n, e)
    end
    event:subscribe(subscription)
    self.events:on("destroy", function() event:unsubscribe(sub) end)
  end

  function Entity:destroy()
    self.events:trigger("destroy")
  end

  function Entity:on(name, func)
    self.events:on(name, func)
  end

  function Entity:is_on_ground()
    return self.on_ground
  end

  function Entity:set_on_ground(on_ground)
    self.on_ground = on_ground
  end

  function Entity:is_ground()
    return false
  end

  function Entity:collide(entity, contact)
  end

  function Entity:uncollide(entity, contact)
  end

  return Entity
end)
