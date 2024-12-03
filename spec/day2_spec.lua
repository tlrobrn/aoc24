local day = require("src.day2")

local TEST_INPUT = {
  "7 6 4 2 1",
  "1 2 7 8 9",
  "9 7 6 2 1",
  "1 3 2 4 5",
  "8 6 4 4 1",
  "1 3 6 7 9",
}

describe("part1", function()
  it("handles the test input", function()
    assert.are.equal(2, day.part1(TEST_INPUT))
  end)
end)
