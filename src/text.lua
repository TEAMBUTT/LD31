knight.module("Game")
.component("text", {"event", "palette", "clock"}, function(event, palette, clock)
  local font = love.graphics.newImageFont("gfx/imagefont.png",
    " abcdefghijklmnopqrstuvwxyz" ..
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
    "123456789.,!?-+/():;%&`'*#=[]\"")
  font:setFilter('nearest', 'nearest', 1)

  local messages = {
    "The screen is broken! I can barely see!\n\nCOLLECT THE BROKEN SCREEN PIECES",
    "I can see a bit better now.\n\nFIND THE REST OF THE BROKEN SCREEN PIECES"
  }
  local top_text = messages[1]

  event:on("piece_collected", function(collected, total)
    if messages[collected + 1] then
      top_text = messages[collected + 1]
    elseif total == collected then
      top_text = "I can see properly again!\n\nTHANK YOU FOR FINDING ALL THE PIECES OF THE SCREEN!"
    else
      top_text = "Just " .. (total - collected) .. " more to go!"
    end
  end)

  event:on("highscores", function(text)
    top_text = "You win.\n\nGLOBAL INTERNET HIGH SCORES\n" .. text
  end)

  event:on("draw_overlay", function()
    love.graphics.setColor(palette.white)
    love.graphics.setFont(font)
    love.graphics.printf(top_text, 0, 50, 512, "center")

    love.graphics.printf(clock:text(), 0, 0, 512, "right")
  end)
end)

