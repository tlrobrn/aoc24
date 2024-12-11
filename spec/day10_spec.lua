local day = require("src.day10")

local TEST_INPUT = {
  "89010123",
  "78121874",
  "87430965",
  "96549874",
  "45678903",
  "32019012",
  "01329801",
  "10456732",
}

describe("part1", function()
  it("handles the test input", function()
    assert.are.equal(36, day.part1(TEST_INPUT))
  end)
end)

describe("part2", function()
  it("handles the test input", function()
    assert.are.equal(81, day.part2(TEST_INPUT))
  end)
end)
