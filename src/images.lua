knight.module("Game")
.component("images", {}, function()
  local loaded_images = {}

  local function load_image(filename)
    return love.graphics.newImage("gfx/" .. filename)
  end

  local function images(filename)
    loaded_images[filename] = loaded_images[filename] or load_image(filename)
    return loaded_images[filename]
  end
  return images
end)
