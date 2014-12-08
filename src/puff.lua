knight.module("Game")
.component("puff",
{"Entity", "player"},
function(Entity)
  local Puff = class("Puff", Entity)

  function Puff:initialize()
  end

  return Puff
end)
