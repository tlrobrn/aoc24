local M = {}

function M.part1(input)
  local total = 0

  for _, line in ipairs(input) do
    for a, b in string.gmatch(line, "mul%((%d%d?%d?),(%d%d?%d?)%)") do
      total = total + (a * b)
    end
  end

  return total
end

function M.part2(input)
  local remainingInput = table.concat(input, " ")
  local enabled = {}

  while string.find(remainingInput, "mul%(%d%d?%d?,%d%d?%d?%)") do
    local endOfSegment, oneBeforeStartOfNextSegment = string.find(remainingInput, "don't()", 1, true)
    endOfSegment = endOfSegment or #remainingInput + 1
    oneBeforeStartOfNextSegment = oneBeforeStartOfNextSegment or #remainingInput

    enabled[#enabled + 1] = string.sub(remainingInput, 1, endOfSegment - 1)
    remainingInput = string.sub(remainingInput, oneBeforeStartOfNextSegment + 1)

    endOfSegment, oneBeforeStartOfNextSegment = string.find(remainingInput, "do()", 1, true)
    endOfSegment = endOfSegment or #remainingInput + 1
    oneBeforeStartOfNextSegment = oneBeforeStartOfNextSegment or #remainingInput

    remainingInput = string.sub(remainingInput, oneBeforeStartOfNextSegment + 1)
  end

  return M.part1(enabled)
end

return M
