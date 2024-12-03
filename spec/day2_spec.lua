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

describe("part2", function()
  it("handles the test input", function()
    assert.are.equal(4, day.part2(TEST_INPUT))
  end)

  it("handles the first being bad", function()
    local input = { "1 9 8 7" }
    assert.are.equal(1, day.part2(input))
  end)

  it("handles the last being bad", function()
    local input = { "9 8 7 8" }
    assert.are.equal(1, day.part2(input))
  end)
end)
