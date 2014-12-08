knight.module("Game")
.component("highscores", {"event"}, function(event)
  highscores = {}

  local scores = null

  local function fetch()
    event:trigger("highscores", {"1:13", "1:16", "2:30", "3:41"})
  end

  event:on("load", fetch)

  return highscores
end)
