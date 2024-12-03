local day = require("src.day3")

describe("part1", function()
  it("handles the test input", function()
    local input = {
      "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))",
    }
    assert.are.equal(161, day.part1(input))
  end)
end)

describe("part2", function()
  it("handles the test input", function()
    local input = {
      "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))",
    }
    assert.are.equal(48, day.part2(input))
  end)
end)
