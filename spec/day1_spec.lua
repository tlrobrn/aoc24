local day = require("src.day1")

describe("part1", function()
  it("handles the test input", function()
    local input = {
      "3   4",
      "4   3",
      "2   5",
      "1   3",
      "3   9",
      "3   3",
    }
    assert.are.equal(11, day.part1(input))
  end)
end)

describe("part2", function()
  it("handles the test input", function()
    local input = {
      "3   4",
      "4   3",
      "2   5",
      "1   3",
      "3   9",
      "3   3",
    }
    assert.are.equal(31, day.part2(input))
  end)
end)
