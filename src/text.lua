knight.module("Game")
.component("text", {"event", "palette"}, function(event, palette)
  local font = love.graphics.newImageFont("gfx/imagefont.png",
    " abcdefghijklmnopqrstuvwxyz" ..
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
    "123456789.,!?-+/():;%&`'*#=[]\"")
  font:setFilter('nearest', 'nearest', 1)

  local messages = {
    "The screen is broken! I can barely see!\n\nCOLLECT THE BROKEN SCREEN PIECES",
    "I can see a bit better now.\n\nMOAR SCREEN PIECES"
  }
  local top_text = messages[1]

  event:on("piece_collected", function(collected, total)
    if messages[collected + 1] then
      top_text = messages[collected + 1]
    elseif total == collected then
      top_text = "You win. I guess."
    else
      top_text = "Just " .. (total - collected) .. " more to go!"
    end
  end)

  event:on("draw_overlay", function()
    love.graphics.setColor(palette.white)
    love.graphics.setFont(font)
    love.graphics.printf(top_text, 0, 50, 512, "center")
  end)
end)

