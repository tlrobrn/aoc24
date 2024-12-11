local M = {}

local function parse(input)
  local stones = {}

  for _, line in ipairs(input) do
    for n in string.gmatch(line, "(%d+)") do
      stones[n] = (stones[n] or 0) + 1
    end
  end

  return stones
end

local function blink(stones)
  local new_stones = {}
  for stone, count in pairs(stones) do
    if stone == "0" then
      new_stones["1"] = (new_stones["1"] or 0) + count
    elseif #stone % 2 == 0 then
      local mid = #stone / 2
      local left = tostring(tonumber(string.sub(stone, 1, mid)))
      local right = tostring(tonumber(string.sub(stone, mid + 1)))
      new_stones[left] = (new_stones[left] or 0) + count
      new_stones[right] = (new_stones[right] or 0) + count
    else
      local prod = tostring(tonumber(stone) * 2024)
      new_stones[prod] = (new_stones[prod] or 0) + count
    end
  end
  return new_stones
end

local function count(stones)
  local total = 0

  for _, value in pairs(stones) do
    total = total + value
  end

  return total
end

function M.part1(input)
  local stones = parse(input)

  for _ = 1, 25 do
    stones = blink(stones)
  end

  return count(stones)
end

function M.part2(input)
  local stones = parse(input)
  for _ = 1, 75 do
    stones = blink(stones)
  end
  return count(stones)
end

return M
