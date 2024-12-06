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
    startingPosition = nil,
  }, self)
end

function World:addObstacle(x, y)
  self.obstacles[encodePoint({ x = x, y = y })] = true
end

function World:removeObstacle(x, y)
  self.obstacles[encodePoint({ x = x, y = y })] = nil
end

function World:hasObstacle(x, y)
  return self.obstacles[encodePoint({ x = x, y = y })]
end

function World:addGuard(x, y)
  self.startingPosition = { x = x, y = y }
  self.guard = Guard:new(x, y)
end

function World:resetGuard()
  self.guard = Guard:new(self.startingPosition.x, self.startingPosition.y)
end

function World:encodeGuardPosition()
  return encodePoint(self.guard)
end

function World:encodeGuardPositionAndDirection()
  return self:encodeGuardPosition() .. ":" .. encodePoint(self.guard.direction)
end

function World:step()
  self.guard:move()
  if self.obstacles[self:encodeGuardPosition()] then
    self.guard:undoMove()
    self.guard:turn()
  end

  return self:withinBounds(self.guard.x, self.guard.y)
end

function World:withinBounds(x, y)
  return x >= 1 and x <= self.width and y >= 1 and y <= self.height
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
  local world = parse(input)
  local locationsToTry = {}
  local alreadyGoingToTry = {}

  while world:step() do
    local pos = { x = world.guard.x, y = world.guard.y }
    for x = -1, 1 do
      for y = -1, 1 do
        local try = { x = pos.x + x, y = pos.y + y }
        if
          not alreadyGoingToTry[encodePoint(try)]
          and (not world:hasObstacle(try.x, try.y))
          and (world.startingPosition.x ~= try.x or world.startingPosition.y ~= try.y)
          and world:withinBounds(try.x, try.y)
        then
          table.insert(locationsToTry, try)
          alreadyGoingToTry[encodePoint(try)] = true
        end
      end
    end
  end

  local count = 0
  for _, location in ipairs(locationsToTry) do
    local x, y = location.x, location.y

    world:resetGuard()
    local seen = {
      [world:encodeGuardPositionAndDirection()] = true,
    }

    world:addObstacle(x, y)
    while world:step() do
      local pos = world:encodeGuardPositionAndDirection()
      if seen[pos] then
        count = count + 1
        goto continue
      end

      seen[pos] = true
    end

    ::continue::
    world:removeObstacle(x, y)
  end

  return count
end

return M
