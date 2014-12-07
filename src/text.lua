knight.module("Game")
.component("text", {"event", "palette"}, function(event, palette)
  local font = love.graphics.newImageFont("gfx/imagefont.png",
    " abcdefghijklmnopqrstuvwxyz" ..
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
    "123456789.,!?-+/():;%&`'*#=[]\"")
  font:setFilter('nearest', 'nearest', 1)

  local top_text = "ZOMG!\nCollect all the broken screen pieces,\nyou noob!"

  event:on("piece_collected", function(collected, total)
    top_text = "Wow! You got one!\n" .. (total - collected) .. " more to go!"
  end)

  event:on("draw_overlay", function()
    love.graphics.setColor(palette.white)
    love.graphics.setFont(font)
    love.graphics.printf(top_text, 0, 50, 512, "center")
  end)
end)

