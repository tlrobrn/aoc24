local M = {}

local function parse(input)
  local memory = {}
  local id = 0
  local free = false
  for c in string.gmatch(table.concat(input, ""), ".") do
    local size = tonumber(c)
    local mem = -1
    if not free then
      mem = id
      id = id + 1
    end

    for _ = 1, size do
      memory[#memory + 1] = mem
    end

    free = not free
  end

  return memory
end

local function layout(memory)
  local tail = #memory
  for head = 1, #memory do
    if memory[head] < 0 then
      while memory[tail] < 0 do
        tail = tail - 1
      end
      if tail <= head then
        return
      end
      memory[head], memory[tail] = memory[tail], memory[head]
      tail = tail - 1
    end
  end
end

local function checksum(memory)
  local result = 0

  for i, m in ipairs(memory) do
    result = result + (i - 1) * math.max(m, 0)
  end

  return result
end

function M.part1(input)
  local memory = parse(input)
  layout(memory)
  return checksum(memory)
end

function M.part2(input)
  return "not implemented"
end

return M
