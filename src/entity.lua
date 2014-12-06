knight.module("Game")
.component("Entity", {"event", "EventListener"}, function(event, EventListener)
  local Entity = class('Entity')

  function Entity:initialize()
    self.deinit_list = {}
    self.events = EventListener:new()
  end

  function Entity:on_destroy(func)
    self.events:on("destroy", func)
  end

  function Entity:destroy()
    self.events:trigger("destroy")
  end

  function Entity:on(name, func)
    event:on(name, func)
    Entity.on_destroy(self, function() event.off(name, func) end)
  end

  return Entity
end)
