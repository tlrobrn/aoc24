local day = require("src.day9")

local TEST_INPUT = { "2333133121414131402" }

describe("part1", function()
  it("handles the test input", function()
    assert.are.equal(1928, day.part1(TEST_INPUT))
  end)

  it("handles the smaller test input", function()
    local input = { "12345" }
    assert.are.equal(60, day.part1(input))
  end)
end)

describe("part2", function()
  it("handles the test input", function()
    assert.are.equal(2858, day.part2(TEST_INPUT))
  end)
end)
