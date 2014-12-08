knight.module("Game")
.component("clock", {"event"}, function(event)
  local clock = {time = 0, frozen = false}
  event:on("update", function(dt)
    if not clock.frozen then
      clock.time = clock.time + dt
    end
  end)

  function clock:freeze()
    clock.frozen = true
  end

  function clock:text()
    local decimal = math.floor(self.time * 10) % 10
    local seconds = math.floor(self.time) % 60
    local minutes = math.floor(self.time / 60) % 60
    local hours = math.floor(self.time / 60 / 60)

    return string.format("%.2i:%.2i.%.1i", minutes, seconds, decimal)
  end

  return clock
end)
