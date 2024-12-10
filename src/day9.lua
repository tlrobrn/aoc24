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

local function advancedparse(input)
  local memory = {}
  local freeBlocks = {}
  local filesBySize = {}
  local id = 0
  local free = false
  for c in string.gmatch(table.concat(input, ""), ".") do
    local size = tonumber(c)
    local block = { head = #memory + 1, size = size }
    local mem = -1
    if not free then
      block.id = id
      filesBySize[block.size] = filesBySize[block.size] or {}
      table.insert(filesBySize[block.size], block)
      mem = id
      id = id + 1
    else
      table.insert(freeBlocks, block)
    end

    for _ = 1, size do
      memory[#memory + 1] = mem
    end

    free = not free
  end

  return memory, { freeBlocks = freeBlocks, filesBySize = filesBySize }
end

local function move(memory, file, free)
  for i = 0, file.size - 1 do
    local to = free.head + i
    local from = file.head + i
    memory[to], memory[from] = memory[from], memory[to]
  end

  local remaining = free.size - file.size
  if remaining > 0 then
    free.head = free.head + file.size
    free.size = remaining
  end

  return { remaining = remaining > 0 }
end

local function condense(memory, map)
  local freePtr = 1
  while freePtr <= #map.freeBlocks do
    local freeBlock = map.freeBlocks[freePtr]
    local fileToMove = { id = -1 }
    for i = 1, freeBlock.size do
      local files = map.filesBySize[i] or {}
      local file = files[#files] or { head = -1 }
      if file.head > freeBlock.head and file.id > fileToMove.id then
        fileToMove = file
      end
    end

    if fileToMove.id > 0 then
      table.remove(map.filesBySize[fileToMove.size] or {})

      local result = move(memory, fileToMove, freeBlock)
      if result.remaining then
        goto continue
      end
    end

    freePtr = freePtr + 1
    ::continue::
  end
end

function M.part2(input)
  local memory, map = advancedparse(input)
  condense(memory, map)
  return checksum(memory)
end

return M
