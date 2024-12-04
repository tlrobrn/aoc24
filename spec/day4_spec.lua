local day = require("src.day4")

describe("part1", function()
  it("handles the test input", function()
    local input = {
      "MMMSXXMASM",
      "MSAMXMSMSA",
      "AMXSXMAAMM",
      "MSAMASMSMX",
      "XMASAMXAMM",
      "XXAMMXXAMA",
      "SMSMSASXSS",
      "SAXAMASAAA",
      "MAMMMXMMMM",
      "MXMXAXMASX",
    }
    assert.are.equal(18, day.part1(input))
  end)
end)
