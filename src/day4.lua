local M = {}

local function buildGrid(input)
  local grid = {}

  for y, line in ipairs(input) do
    grid[y] = {}
    for c in string.gmatch(line, ".") do
      grid[y][#grid[y] + 1] = c
    end
  end

  return grid
end

local Grid = {}
Grid.__index = Grid

function Grid:new(input)
  local instance = setmetatable({}, self)
  instance.grid = buildGrid(input)
  return instance
end

function Grid:at(x, y)
  return (self.grid[y] or {})[x]
end

function Grid:width()
  return #self.grid[1]
end

function Grid:height()
  return #self.grid
end

local function checkEast(grid, x, y)
  if grid:at(x, y) ~= "X" then
    return false
  end

  if grid:at(x + 1, y) ~= "M" then
    return false
  end

  if grid:at(x + 2, y) ~= "A" then
    return false
  end

  if grid:at(x + 3, y) ~= "S" then
    return false
  end

  return true
end

local function checkWest(grid, x, y)
  if grid:at(x, y) ~= "X" then
    return false
  end

  if grid:at(x - 1, y) ~= "M" then
    return false
  end

  if grid:at(x - 2, y) ~= "A" then
    return false
  end

  if grid:at(x - 3, y) ~= "S" then
    return false
  end

  return true
end

local function checkNorth(grid, x, y)
  if grid:at(x, y) ~= "X" then
    return false
  end

  if grid:at(x, y - 1) ~= "M" then
    return false
  end

  if grid:at(x, y - 2) ~= "A" then
    return false
  end

  if grid:at(x, y - 3) ~= "S" then
    return false
  end

  return true
end

local function checkSouth(grid, x, y)
  if grid:at(x, y) ~= "X" then
    return false
  end

  if grid:at(x, y + 1) ~= "M" then
    return false
  end

  if grid:at(x, y + 2) ~= "A" then
    return false
  end

  if grid:at(x, y + 3) ~= "S" then
    return false
  end

  return true
end

local function checkNorthEast(grid, x, y)
  if grid:at(x, y) ~= "X" then
    return false
  end

  if grid:at(x + 1, y - 1) ~= "M" then
    return false
  end

  if grid:at(x + 2, y - 2) ~= "A" then
    return false
  end

  if grid:at(x + 3, y - 3) ~= "S" then
    return false
  end

  return true
end

local function checkSouthEast(grid, x, y)
  if grid:at(x, y) ~= "X" then
    return false
  end

  if grid:at(x + 1, y + 1) ~= "M" then
    return false
  end

  if grid:at(x + 2, y + 2) ~= "A" then
    return false
  end

  if grid:at(x + 3, y + 3) ~= "S" then
    return false
  end

  return true
end

local function checkSouthWest(grid, x, y)
  if grid:at(x, y) ~= "X" then
    return false
  end

  if grid:at(x - 1, y + 1) ~= "M" then
    return false
  end

  if grid:at(x - 2, y + 2) ~= "A" then
    return false
  end

  if grid:at(x - 3, y + 3) ~= "S" then
    return false
  end

  return true
end

local function checkNorthWest(grid, x, y)
  if grid:at(x, y) ~= "X" then
    return false
  end

  if grid:at(x - 1, y - 1) ~= "M" then
    return false
  end

  if grid:at(x - 2, y - 2) ~= "A" then
    return false
  end

  if grid:at(x - 3, y - 3) ~= "S" then
    return false
  end

  return true
end

local DIRECTIONS =
  { checkNorth, checkNorthEast, checkEast, checkSouthEast, checkSouth, checkSouthWest, checkWest, checkNorthWest }

local function checkAllDirections(grid, x, y)
  local count = 0
  for _, check in ipairs(DIRECTIONS) do
    if check(grid, x, y) then
      count = count + 1
    end
  end

  return count
end

local function checkX(grid, x, y)
  if grid:at(x, y) ~= "A" then
    return 0
  end

  local northWest = grid:at(x - 1, y - 1)
  local southWest = grid:at(x - 1, y + 1)
  local northEast = grid:at(x + 1, y - 1)
  local southEast = grid:at(x + 1, y + 1)

  if not ((northWest == "M" and southEast == "S") or (northWest == "S" and southEast == "M")) then
    return 0
  end

  if not ((southWest == "M" and northEast == "S") or (southWest == "S" and northEast == "M")) then
    return 0
  end

  return 1
end

function M.part1(input)
  local count = 0
  local grid = Grid:new(input)

  for x = 1, grid:width() do
    for y = 1, grid:height() do
      count = count + checkAllDirections(grid, x, y)
    end
  end

  return count
end

function M.part2(input)
  local count = 0
  local grid = Grid:new(input)

  for x = 1, grid:width() do
    for y = 1, grid:height() do
      count = count + checkX(grid, x, y)
    end
  end

  return count
end

return M
