knight.module("Game")
.component("clock", {"event"}, function(event)
  local clock = {time = 0, frozen = false}
  event:on("update", function(dt)
    if not clock.frozen then
      clock.time = clock.time + dt
    end
  end)

  event:on("victory", function()
    highscores:submit(clock.time)
    clock:freeze()
  end)

  function clock:freeze()
    clock.frozen = true
  end

  function clock.format(time)
    local decimal = math.floor(time * 10) % 10
    local seconds = math.floor(time) % 60
    local minutes = math.floor(time / 60) % 60
    local hours = math.floor(time / 60 / 60)

    return string.format("%.2i:%.2i.%.1i", minutes, seconds, decimal)
  end

  function clock:text()
    return self.format(self.time)
  end

  return clock
end)
