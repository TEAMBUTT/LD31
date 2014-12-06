knight.module("Game")
.component("Entity", {"event"}, function(event)
  local Entity = class('Entity')

  function Entity:initialize()
    self.deinit_list = {}
  end

  function Entity:on_destroy(func)
    table.insert(self.deinit_list, func)
  end

  function Entity:destroy()
    _.each(self.deinit_list, function(f) f() end)
  end

  function Entity:on(name, func)
    event:on(name, func)
    Entity.on_destroy(self, function() event.off(name, func) end)
  end

  return Entity
end)
