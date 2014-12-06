
knight.module("Game").component("event", {}, function()
  local callbacks = {}
  local function get(name)
    if not callbacks[name] then
      callbacks[name] = {}
    end
    return callbacks[name]
  end

  return {
    on = function(name, func)
      table.insert(get(name), func)
    end,
    off = function(name, func)
      callbacks[name] = _.reject(get(name), function(f)
        return f == func
      end)
    end,
    trigger = function(name, e)
      for i, func in ipairs(get(name)) do
        func(e)
      end
    end
  }
end)
