local day = require("src.day3")

local TEST_INPUT = {
  "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))",
}

describe("part1", function()
  it("handles the test input", function()
    assert.are.equal(161, day.part1(TEST_INPUT))
  end)
end)
