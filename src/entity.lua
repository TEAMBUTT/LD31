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
    self.events:on("destroy", function() event:unsubscribe(subscription) end)
  end

  function Entity:destroy()
    self.events:trigger("destroy")
  end

  function Entity:on(name, func)
    self.events:on(name, func)
  end

  function Entity:trigger(name, ...)
    self.events:trigger(name, ...)
  end

  return Entity
end)
