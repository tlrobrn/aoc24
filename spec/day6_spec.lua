local day = require("src.day6")

local TEST_INPUT = {
  "....#.....",
  ".........#",
  "..........",
  "..#.......",
  ".......#..",
  "..........",
  ".#..^.....",
  "........#.",
  "#.........",
  "......#...",
}

describe("part1", function()
  it("handles the test input", function()
    assert.are.equal(41, day.part1(TEST_INPUT))
  end)
end)