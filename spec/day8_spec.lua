local day = require("src.day8")

local TEST_INPUT = {
  "............",
  "........0...",
  ".....0......",
  ".......0....",
  "....0.......",
  "......A.....",
  "............",
  "............",
  "........A...",
  ".........A..",
  "............",
  "............",
}

describe("part1", function()
  it("handles the test input", function()
    assert.are.equal(14, day.part1(TEST_INPUT))
  end)
end)
