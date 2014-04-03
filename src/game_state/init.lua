
local GameState = class 'GameState'

function GameState:update()
  error 'must be overridden'
end

function GameState:draw()
  error 'must be overridden'
end

return GameState
