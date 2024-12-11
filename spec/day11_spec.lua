local day = require("src.day11")

local TEST_INPUT = {
  "125 17",
}

describe("part1", function()
  it("handles the test input", function()
    assert.are.equal(55312, day.part1(TEST_INPUT))
  end)
end)
