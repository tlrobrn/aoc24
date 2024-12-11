local M = {}

local function encoder(width, height)
  local function encode(x, y)
    if x < 1 or x > width or y < 1 or y > height then
      return -1
    end
    return (y - 1) * width + (x - 1) + 1
  end
  local function decode(z)
    local zp = z - 1
    local yp = math.floor(zp / width)
    local xp = zp % width
    return xp + 1, yp + 1
  end

  return encode, decode
end

local function newNode(h)
  return {
    neighbors = {},
    h = h,
  }
end

local cache = {}

local Graph = {}
Graph.__index = Graph

function Graph:new(input)
  if cache[input] then
    return cache[input]
  end

  local nodes = {}
  local heads = {}
  local encode, decode = encoder(#input[1], #input)

  for y, line in ipairs(input) do
    local x = 1
    for c in string.gmatch(line, ".") do
      local h = tonumber(c)
      local z = encode(x, y)
      local node = newNode(h)
      nodes[z] = node
      if h == 0 then
        heads[#heads + 1] = node
      end
      x = x + 1
    end
  end

  for z, node in ipairs(nodes) do
    local x, y = decode(z)
    local neighbors = {
      nodes[encode(x, y - 1)],
      nodes[encode(x, y + 1)],
      nodes[encode(x - 1, y)],
      nodes[encode(x + 1, y)],
    }

    for _, neighbor in pairs(neighbors) do
      if node.h + 1 == neighbor.h then
        table.insert(node.neighbors, neighbor)
      end
    end
  end

  cache[input] = setmetatable({
    nodes = nodes,
    heads = heads,
  }, self)

  return cache[input]
end

local function shallowCopy(t)
  local copy = {}
  for k, v in pairs(t) do
    copy[k] = v
  end
  return copy
end

local function scoreNode(node)
  local count = 0
  local seen = {}
  local paths = shallowCopy(node.neighbors)
  while #paths > 0 do
    local path = table.remove(paths)
    for _, neighbor in ipairs(path.neighbors) do
      paths[#paths + 1] = neighbor
    end
    if path.h == 9 and not seen[path] then
      count = count + 1
      seen[path] = true
    end
  end
  return count
end

local function rateNode(node)
  local count = 0
  local paths = shallowCopy(node.neighbors)
  while #paths > 0 do
    local path = table.remove(paths)
    for _, neighbor in ipairs(path.neighbors) do
      paths[#paths + 1] = neighbor
    end
    if path.h == 9 then
      count = count + 1
    end
  end
  return count
end

function Graph:score()
  local total = 0
  for _, head in ipairs(self.heads) do
    total = total + scoreNode(head)
  end
  return total
end

function Graph:rating()
  local total = 0
  for _, head in ipairs(self.heads) do
    total = total + rateNode(head)
  end
  return total
end

function M.part1(input)
  local graph = Graph:new(input)
  return graph:score()
end

function M.part2(input)
  local graph = Graph:new(input)
  return graph:rating()
end

return M
