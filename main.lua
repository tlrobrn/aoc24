-- make compatible with both lua and luajit
if not table.unpack then
  ---@diagnostic disable-next-line: deprecated
  table.unpack = unpack
end

local function load_day(n)
  return require("src.day" .. n)
end

local function read_input()
  local input = {}
  for line in io.stdin:lines() do
    table.insert(input, line)
  end
  return input
end

local function parts()
  local userPart = arg[2]
  if userPart then
    return { userPart }
  end

  return { 1, 2 }
end

local day = load_day(arg[1])
local input = read_input()

for _, part in ipairs(parts()) do
  local result = day["part" .. part](input)
  print("Part " .. part .. ": " .. result)
end
