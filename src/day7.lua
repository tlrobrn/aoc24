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
    local results = { test.numbers[1] }
    for i = 2, #test.numbers do
      local possibilities = {}
      local n = test.numbers[i]
      for _, m in ipairs(results) do
        possibilities[#possibilities + 1] = m + n
        possibilities[#possibilities + 1] = m * n
      end
      results = possibilities
    end

    for _, result in ipairs(results) do
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
    local results = { test.numbers[1] }
    for i = 2, #test.numbers do
      local possibilities = {}
      local n = test.numbers[i]
      for _, m in ipairs(results) do
        possibilities[#possibilities + 1] = m + n
        possibilities[#possibilities + 1] = m * n
        possibilities[#possibilities + 1] = tonumber(m .. n)
      end
      results = possibilities
    end

    for _, result in ipairs(results) do
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
