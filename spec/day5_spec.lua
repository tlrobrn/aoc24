local day = require("src.day5")

local TEST_INPUT = {
  "47|53",
  "97|13",
  "97|61",
  "97|47",
  "75|29",
  "61|13",
  "75|53",
  "29|13",
  "97|29",
  "53|29",
  "61|53",
  "97|53",
  "61|29",
  "47|13",
  "75|47",
  "97|75",
  "47|61",
  "75|61",
  "47|29",
  "75|13",
  "53|13",
  "",
  "75,47,61,53,29",
  "97,61,53,29,13",
  "75,29,13",
  "75,97,47,61,53",
  "61,13,29",
  "97,13,75,29,47",
}

describe("part1", function()
  it("handles the test input", function()
    assert.are.equal(143, day.part1(TEST_INPUT))
  end)
end)

describe("part2", function()
  it("handles the test input", function()
    assert.are.equal(123, day.part2(TEST_INPUT))
  end)
end)
