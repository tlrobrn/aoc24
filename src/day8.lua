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

local function allAlongLineWithinBounds(points, width, height)
  local result = { count = 0 }

  function inbounds(x, y)
    return x >= 1 and x <= width and y >= 1 and y <= height
  end

  for _, pointList in pairs(points) do
    if #pointList < 2 then
      goto skip
    end

    for i = 1, #pointList - 1 do
      local x1, y1 = table.unpack(pointList[i])
      if not result[x1 .. "," .. y1] then
        result.count = result.count + 1
        result[x1 .. "," .. y1] = true
      end

      for j = i + 1, #pointList do
        local x2, y2 = table.unpack(pointList[j])
        if not result[x2 .. "," .. y2] then
          result.count = result.count + 1
          result[x2 .. "," .. y2] = true
        end
        local dx, dy = x2 - x1, y2 - y1
        -- increase
        local x, y = x2 + dx, y2 + dy
        while inbounds(x, y) do
          if not result[x .. "," .. y] then
            result.count = result.count + 1
            result[x .. "," .. y] = true
          end
          x, y = x + dx, y + dy
        end
        -- decrease
        x, y = x1 - dx, y1 - dy
        while inbounds(x, y) do
          if not result[x .. "," .. y] then
            result.count = result.count + 1
            result[x .. "," .. y] = true
          end
          x, y = x - dx, y - dy
        end
      end
    end
    ::skip::
  end

  return result
end

function M.part2(input)
  local points, width, height = parse(input)
  local antinodes = allAlongLineWithinBounds(points, width, height)
  return antinodes.count
end

return M
