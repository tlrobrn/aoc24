require("src.stringutils")

local M = {}

local function parseReports(input)
  local reports = {}

  for _, line in ipairs(input) do
    local report = {}

    for _, c in ipairs(string.split(line, "%s+")) do
      report[#report + 1] = tonumber(c)
    end

    reports[#reports + 1] = report
  end

  return reports
end

local function isSafe(report)
  if #report < 2 then
    return true
  end

  local reportDirection

  for j = 2, #report do
    local i = j - 1
    local a, b = report[i], report[j]
    local direction = a - b < 0 and "inc" or "dec"
    reportDirection = reportDirection or direction

    if direction ~= reportDirection then
      return false
    end

    if a == b or math.abs(a - b) > 3 then
      return false
    end
  end

  return true
end

function M.part1(input)
  local reports = parseReports(input)
  local safeCount = 0

  for _, report in ipairs(reports) do
    if isSafe(report) then
      safeCount = safeCount + 1
    end
  end

  return safeCount
end

function M.part2(input)
  return "not implemented"
end

return M
