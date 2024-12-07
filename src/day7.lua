require("src.stringutils")

local M = {}

local cache = {}

local function parse(input)
  if not cache[input] then
    local tests = {}
    for _, line in ipairs(input) do
      local expected, equation = string.match(line, "(%d+):%s+(.+)")
      local numbers = {}
      for _, number in ipairs(string.split(equation, " ")) do
        numbers[#numbers + 1] = tonumber(number)
      end

      tests[#tests + 1] = { expected = tonumber(expected), numbers = numbers }
    end

    cache[input] = tests
  end

  return cache[input]
end

function M.part1(input)
  local tests = parse(input)
  local total = 0

  for _, test in ipairs(tests) do
    local possibilities = { test.numbers[1] }
    for i = 2, #test.numbers do
      local n = test.numbers[i]
      local applyTo = math.pow(2, i - 2)
      local start = #possibilities
      for j = 0, applyTo - 1 do
        local at = start - j
        possibilities[#possibilities + 1] = possibilities[at] + n
        possibilities[#possibilities + 1] = possibilities[at] * n
      end
    end

    local check = math.pow(2, #test.numbers - 1)
    local start = #possibilities
    for i = 0, check - 1 do
      local result = possibilities[start - i]
      if test.expected == result then
        total = total + test.expected
        goto continue
      end
    end

    ::continue::
  end

  return total
end

function M.part2(input)
  local tests = parse(input)
  local total = 0

  for _, test in ipairs(tests) do
    local possibilities = { test.numbers[1] }
    for i = 2, #test.numbers do
      local n = test.numbers[i]
      local applyTo = math.pow(3, i - 2)
      local start = #possibilities
      for j = 0, applyTo - 1 do
        local at = start - j
        possibilities[#possibilities + 1] = possibilities[at] + n
        possibilities[#possibilities + 1] = possibilities[at] * n
        possibilities[#possibilities + 1] = tonumber(possibilities[at] .. n)
      end
    end

    local check = math.pow(3, #test.numbers - 1)
    local start = #possibilities
    for i = 0, check - 1 do
      local result = possibilities[start - i]
      if test.expected == result then
        total = total + test.expected
        goto continue
      end
    end

    ::continue::
  end

  return total
end

return M
