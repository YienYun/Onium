-- Script path: ReplicatedStorage.Packages._Index.roblox_testez@0.4.1.testez.Reporters.TextReporterQuiet
-- Decompile time: 2.36 ms

local reportNode
local TestService = game:GetService("TestService")
local TestEnum = require(script.Parent.Parent.TestEnum)
local u15 = (" "):rep(3)
local u16 = {
    [TestEnum.TestStatus.Success] = "+",
    [TestEnum.TestStatus.Failure] = "-",
    [TestEnum.TestStatus.Skipped] = "~",
}
local v1 = {}

function reportNode(a1, a2, a3) -- Line: 22 -- upvalues: TestEnum (val), u16 (val), u15 (val), reportNode (val)
    local v1 = a2 or {}
    local v2 = a3 or 0
    if a1.status == TestEnum.TestStatus.Skipped then
        return v1
    end
    local v3 = nil
    if a1.status ~= TestEnum.TestStatus.Success then
        local v4 = u16[a1.status] or "?"
        v3 = ("%s[%s] %s"):format(u15:rep(v2), v4, a1.planNode.phrase)
    end
    table.insert(v1, v3)
    for i, v in ipairs(a1.children) do
        reportNode(v, v1, v2 + 1)
    end
    return v1
end

local function reportRoot(a1) -- Line: 47 -- upvalues: reportNode (val)
    local v1 = {}
    for i, v in ipairs(a1.children) do
        reportNode(v, v1, 0)
    end
    return v1
end

local function report(a1) -- Line: 57 -- upvalues: reportRoot (val)
    return table.concat(reportRoot(a1), "\n")
end

function v1.report(a1) -- Line: 63 -- upvalues: reportRoot (val), TestService (val)
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