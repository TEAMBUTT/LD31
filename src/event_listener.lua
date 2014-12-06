knight.module("Game")
.component("EventListener", {}, function()
  local EventListener = class('EventListener')

  function EventListener:initialize()
    self.subscribers = {}
  end

  function EventListener:on(event, func)
    self:subscribe(function(name, e)
      if name == event then
        func(e)
      end
    end)
  end

  function EventListener:trigger(name, e)
    for i, func in ipairs(self.subscribers) do
      func(name, e)
    end
  end

  function EventListener:subscribe(func)
    table.insert(self.subscribers, func)
  end

  function EventListener:unsubscribe(func)
    callbacks[name] = _.reject(get(name), function(f)
      return f == func
    end)
  end

  return EventListener
end)
