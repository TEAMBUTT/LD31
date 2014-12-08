knight.module("Game")
.component("audio", {"event"}, function(event)
  local function play_music(filename)
    local music = love.audio.newSource("audio/" .. filename)
    music:play()
  end

  event:on("load", function() play_music("music.wav") end)
end)
