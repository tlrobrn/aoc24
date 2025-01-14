local day = require("src.day7")

local TEST_INPUT = {
  "190: 10 19",
  "3267: 81 40 27",
  "83: 17 5",
  "156: 15 6",
  "7290: 6 8 6 15",
  "161011: 16 10 13",
  "192: 17 8 14",
  "21037: 9 7 18 13",
  "292: 11 6 16 20",
}

describe("part1", function()
  it("handles the test input", function()
    assert.are.equal(3749, day.part1(TEST_INPUT))
  end)
end)

describe("part2", function()
  it("handles the test input", function()
    assert.are.equal(11387, day.part2(TEST_INPUT))
  end)
end)
