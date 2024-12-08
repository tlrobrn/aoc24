require("src.stringutils")

local M = {}

local function parse(input)
  local points = {}

  for y, line in ipairs(input) do
    local x = 1
    for c in string.gmatch(line, ".") do
      if c ~= "." then
        points[c] = points[c] or {}
        table.insert(points[c], { tonumber(x), tonumber(y) })
      end
      x = x + 1
    end
  end

  return points, #input[1], #input
end

local function allAntinodes(points)
  local antinodes = {}

  for freq, pointList in pairs(points) do
    for i = 1, #pointList - 1 do
      local x1, y1 = table.unpack(pointList[i])
      for j = i + 1, #pointList do
        local x2, y2 = table.unpack(pointList[j])
        local dx = (x2 - x1)
        local dy = (y2 - y1)
        local x0, x3 = x1 - dx, x2 + dx
        local y0, y3 = y1 - dy, y2 + dy

        antinodes[#antinodes + 1] = { x0, y0 }
        antinodes[#antinodes + 1] = { x3, y3 }
      end
    end
  end

  return antinodes
end

function M.part1(input)
  local points, width, height = parse(input)
  local antinodes = allAntinodes(points)
  local count = 0
  local seen = {}

  for _, antinode in ipairs(antinodes) do
    local x, y = table.unpack(antinode)
    if x >= 1 and x <= width and y >= 1 and y <= height and not seen[x .. "," .. y] then
      count = count + 1
      seen[x .. "," .. y] = true
    end
  end

  return count
end

function M.part2(input)
  return "not implemented"
end

return M
