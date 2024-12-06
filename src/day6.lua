require("src.stringutils")

local M = {}

local function encodePoint(point)
  return point.x .. "," .. point.y
end

local Guard = {}
Guard.__index = Guard

function Guard:new(x, y)
  return setmetatable({
    x = x,
    y = y,
    direction = { x = 0, y = -1 },
  }, self)
end

function Guard:move()
  self.x = self.x + self.direction.x
  self.y = self.y + self.direction.y
end

function Guard:undoMove()
  self.x = self.x - self.direction.x
  self.y = self.y - self.direction.y
end

function Guard:turn()
  self.direction.x, self.direction.y = -self.direction.y, self.direction.x
end

local World = {}
World.__index = World

function World:new()
  return setmetatable({
    obstacles = {},
    width = nil,
    height = nil,
    guard = nil,
  }, self)
end

function World:addObstacle(x, y)
  self.obstacles[encodePoint({ x = x, y = y })] = true
end

function World:addGuard(x, y)
  self.guard = Guard:new(x, y)
end

function World:encodeGuardPosition()
  return encodePoint(self.guard)
end

function World:step()
  self.guard:move()
  if self.obstacles[self:encodeGuardPosition()] then
    self.guard:undoMove()
    self.guard:turn()
  end

  return self.guard.x >= 1 and self.guard.x <= self.width and self.guard.y >= 1 and self.guard.y <= self.height
end

local function parse(input)
  local world = World:new()
  world.height = #input

  for y, line in ipairs(input) do
    world.width = world.width or #line
    local x = 1
    for c in string.gmatch(line, ".") do
      if c == "#" then
        world:addObstacle(x, y)
      elseif c == "^" then
        world:addGuard(x, y)
      end
      x = x + 1
    end
  end

  return world
end

function M.part1(input)
  local world = parse(input)
  local seen = {
    [world:encodeGuardPosition()] = true,
  }
  local count = 1

  while world:step() do
    local pos = world:encodeGuardPosition()
    if not seen[pos] then
      seen[pos] = true
      count = count + 1
    end
  end

  return count
end

function M.part2(input)
  return "not implemented"
end

return M
