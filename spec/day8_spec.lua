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

describe("part2", function()
  it("handles the test input", function()
    assert.are.equal(34, day.part2(TEST_INPUT))
  end)

  it("handles the other test input", function()
    local input = {
      "T.........",
      "...T......",
      ".T........",
      "..........",
      "..........",
      "..........",
      "..........",
      "..........",
      "..........",
      "..........",
    }

    assert.are.equal(9, day.part2(input))
  end)
end)
