require("src.stringutils")

local M = {}

local function parse(input)
  local ordering = {}
  local reports = {}

  local finishedOrdering = false

  for _, line in ipairs(input) do
    if finishedOrdering then
      local report = {}
      for i, n in ipairs(string.split(line, ",")) do
        report[i] = tonumber(n)
      end
      reports[#reports + 1] = report
      goto continue
    end

    local a, b = string.match(line, "(%d+)|(%d+)")
    a = tonumber(a)
    b = tonumber(b)

    if not a or not b then
      finishedOrdering = true
      goto continue
    end

    ordering[a] = ordering[a] or {}
    ordering[a][b] = true

    ::continue::
  end

  return ordering, reports
end

local function inOrder(t, ordering)
  if #t < 2 then
    return true
  end

  for i=1,#t-1 do
    local a, b = t[i], t[i + 1]
    if (ordering[b] or {})[a] then
      return false
    end
  end

  return true
end

function M.part1(input)
  local ordering, reports = parse(input)

  local total = 0
  for _,report in ipairs(reports) do
    local len = #report
    local mid = math.ceil(len / 2)
    if inOrder(report, ordering) then
      total = total + report[mid]
    end
  end
  return total
end

function M.part2(input)
  local ordering, reports = parse(input)

  local total = 0
  for _,report in ipairs(reports) do
    local len = #report
    local mid = math.ceil(len / 2)
    if not inOrder(report, ordering) then
      while not inOrder(report, ordering) do
        table.sort(report, function(a,b)
          return not (ordering[b] or {})[a]
        end)
      end
      total = total + report[mid]
    end
  end
  return total
end

return M
