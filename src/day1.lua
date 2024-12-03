require("src.stringutils")

local M = {}

local function getSortedLists(input)
  local leftList = {}
  local rightList = {}
  for _, line in ipairs(input) do
    local left, right = table.unpack(string.split(line, "%s+"))
    leftList[#leftList + 1] = tonumber(left)
    rightList[#rightList + 1] = tonumber(right)
  end
  table.sort(leftList)
  table.sort(rightList)
  return leftList, rightList
end

function M.part1(input)
  local leftList, rightList = getSortedLists(input)
  local total = 0

  for i = 1, #leftList do
    local left = leftList[i]
    local right = rightList[i]

    total = total + math.abs(left - right)
  end

  return total
end

local function counts(list)
  local result = {}

  for _, entry in ipairs(list) do
    result[entry] = (result[entry] or 0) + 1
  end

  return result
end

function M.part2(input)
  local leftList, rightList = getSortedLists(input)
  local similarityScore = 0
  local rightCounts = counts(rightList)

  for _, entry in ipairs(leftList) do
    similarityScore = similarityScore + entry * (rightCounts[entry] or 0)
  end

  return similarityScore
end

return M
