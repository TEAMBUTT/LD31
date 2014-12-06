knight.module("Game")
.component("palette", {}, function()
  local palette = {}

  palette.black = {0, 0, 0}
  palette.white = {255, 255, 255}
  palette.red = {136, 0, 0}
  palette.cyan = {170, 255, 238}
  palette.violet = {204, 68, 204}
  palette.green = {0, 204, 85}
  palette.blue = {0, 0, 170}
  palette.yellow = {238, 238, 119}
  palette.orange = {221, 136, 85}
  palette.brown = {102, 68, 0}
  palette.lightred = {255, 119, 119}
  palette.grey1 = {51, 51, 51}
  palette.grey2 = {119, 119, 119}
  palette.lightgreen = {170, 255, 102}
  palette.lightblue = {0, 136, 255}
  palette.grey3 = {187, 187, 187}

  return palette
end)
