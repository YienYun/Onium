-- Script path: ReplicatedStorage.Packages._Index.roblox_testez@0.4.1.testez.Reporters.TeamCityReporter
-- Decompile time: 3.42 ms

local reportNode
local TestService = game:GetService("TestService")
local TestEnum = require(script.Parent.Parent.TestEnum)
local v1 = {}

local function teamCityEscape(a1) -- Line: 7
    return (string.gsub(string.gsub(string.gsub(a1, "([]|'[])", "|%1"), "\r", "|r"), "\n", "|n"))
end

local function teamCityEnterSuite(a1) -- Line: 14
    return string.format(
        "##teamcity[testSuiteStarted name='%s']",
        (string.gsub(string.gsub(string.gsub(a1, "([]|'[])", "|%1"), "\r", "|r"), "\n", "|n"))
    )
end

local function teamCityLeaveSuite(a1) -- Line: 18
    return string.format(
        "##teamcity[testSuiteFinished name='%s']",
        (string.gsub(string.gsub(string.gsub(a1, "([]|'[])", "|%1"), "\r", "|r"), "\n", "|n"))
    )
end

local function teamCityEnterCase(a1) -- Line: 22
    return string.format(
        "##teamcity[testStarted name='%s']",
        (string.gsub(string.gsub(string.gsub(a1, "([]|'[])", "|%1"), "\r", "|r"), "\n", "|n"))
    )
end

local function teamCityLeaveCase(a1) -- Line: 26
    return string.format(
        "##teamcity[testFinished name='%s']",
        (string.gsub(string.gsub(string.gsub(a1, "([]|'[])", "|%1"), "\r", "|r"), "\n", "|n"))
    )
end

local function teamCityFailCase(a1, a2) -- Line: 30
    return string.format(
        "##teamcity[testFailed name='%s' message='%s']",
        string.gsub(string.gsub(string.gsub(a1, "([]|'[])", "|%1"), "\r", "|r"), "\n", "|n"),
        (string.gsub(string.gsub(string.gsub(a2, "([]|'[])", "|%1"), "\r", "|r"), "\n", "|n"))
    )
end

function reportNode(a1, a2, a3) -- Line: 38
    -- upvalues: TestEnum (val), teamCityEnterSuite (val), reportNode (val), teamCityLeaveSuite (val)
    -- upvalues: teamCityEnterCase (val), teamCityFailCase (val), teamCityLeaveCase (val)
    local v1 = a2 or {}
    if a1.status == TestEnum.TestStatus.Skipped then
        return v1
    end
    if a1.planNode.type == TestEnum.NodeType.Describe then
        table.insert(v1, (teamCityEnterSuite(a1.planNode.phrase)))
        for i, v in ipairs(a1.children) do
            reportNode(v, v1, (a3 or 0) + 1)
        end
        table.insert(v1, (teamCityLeaveSuite(a1.planNode.phrase)))
        return
    end
    table.insert(v1, (teamCityEnterCase(a1.planNode.phrase)))
    if a1.status == TestEnum.TestStatus.Failure then
        table.insert(v1, (teamCityFailCase(a1.planNode.phrase, (table.concat(a1.errors, "\n")))))
    end
    table.insert(v1, (teamCityLeaveCase(a1.planNode.phrase)))
end

local function reportRoot(a1) -- Line: 59 -- upvalues: reportNode (val)
    local v1 = {}
    for i, v in ipairs(a1.children) do
        reportNode(v, v1, 0)
    end
    return v1
end

local function report(a1) -- Line: 69 -- upvalues: reportRoot (val)
    return table.concat(reportRoot(a1), "\n")
end

function v1.report(a1) -- Line: 75 -- upvalues: reportRoot (val), TestService (val)
    local v1 = {
        "Test results:",
        table.concat(reportRoot(a1), "\n"),
        (("%d passed, %d failed, %d skipped"):format(a1.successCount, a1.failureCount, a1.skippedCount)),
    }
    print(table.concat(v1, "\n"))
    if 0 < a1.failureCount then
        print(("%d test nodes reported failures."):format(a1.failureCount))
    end
    if #a1.errors > 0 then
        print("Errors reported by tests:")
        print("")
        for i, v in ipairs(a1.errors) do
            TestService:Error(v)
            print("")
        end
    end
end

return v1