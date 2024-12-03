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
  return "not implemented"
end

return M
