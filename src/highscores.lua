knight.module("Game")
.component("highscores", {"event"}, function(event)
  highscores = {}

  local scores = null

  function highscores:submit(time)
    -- blocking... but the API is evented, so we could fix this someday
    local http = require("socket.http")
    local b, c, h = http.request("http://localhost:9292/scores", "time=" .. time)
    if c == 200 then
      event:trigger("highscores", b)
    end
  end

  return highscores
end)
