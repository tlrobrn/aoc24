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

function M.part2(input)
  return "not implemented"
end

return M
