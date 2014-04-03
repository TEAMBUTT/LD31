require 'spec_helper'

GameState = require('game_state')

describe("GameState", function()

  local state = let("state", function()
    return GameState:new()
  end)

  describe(":update", function()
    it("throws an error", function()
      assert.has_error(function()
        state():update(23)
      end, 'must be overridden')
    end)
  end)

  describe(":draw", function()
    it("throws an error", function()
      assert.has_error(function()
        state():draw()
      end, 'must be overridden')
    end)
  end)

end)
