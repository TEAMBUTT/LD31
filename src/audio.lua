knight.module("Game")
.component("audio", {"event"}, function(event)
  local function play_music(filename)
    local music = love.audio.newSource("audio/" .. filename)
    music:setLooping(true)
    music:play()
  end

  local function play_sound(filename)
    local sound = love.audio.newSource("audio/" .. filename)
    sound:play()
  end

  event:on("load", function() play_music("DT3.mp3") end)
  event:on("piece_collected", function() play_sound("screen_piece.wav") end)
  event:on("jump", function() play_sound("jump.wav") end)
  event:on("bump", function() play_sound("bump.wav") end)
end)
