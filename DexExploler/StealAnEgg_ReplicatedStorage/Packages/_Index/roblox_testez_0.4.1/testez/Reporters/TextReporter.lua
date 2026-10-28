-- Script path: ReplicatedStorage.Packages._Index.roblox_testez@0.4.1.testez.Reporters.TextReporter
-- Decompile time: 2.35 ms

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

local function compareNodes(a1, a2) -- Line: 20
    return (a1.planNode.phrase:lower()) < a2.planNode.phrase:lower()
end

function reportNode(a1, a2, a3) -- Line: 24
    -- upvalues: TestEnum (val), u16 (val), u15 (val), compareNodes (val), reportNode (val)
    local v1 = a2 or {}
    local v2 = v1
    local v3 = a3 or 0
    if a1.status == TestEnum.TestStatus.Skipped then
        return v2
    end
    if not a1.status then
        v1 = ("%s%s"):format(u15:rep(v3), a1.planNode.phrase)
    else
        local v4 = u16[a1.status] or "?"
        v1 = ("%s[%s] %s"):format(u15:rep(v3), v4, a1.planNode.phrase)
    end
    table.insert(v2, v1)
    table.sort(a1.children, compareNodes)
    for i, v in ipairs(a1.children) do
        reportNode(v, v2, v3 + 1)
    end
    return v2
end

local function reportRoot(a1) -- Line: 52 -- upvalues: compareNodes (val), reportNode (val)
    local v1 = {}
    table.sort(a1.children, compareNodes)
    for i, v in ipairs(a1.children) do
        reportNode(v, v1, 0)
    end
    return v1
end

local function report(a1) -- Line: 63 -- upvalues: reportRoot (val)
    return table.concat(reportRoot(a1), "\n")
end

function v1.report(a1) -- Line: 69 -- upvalues: reportRoot (val), TestService (val)
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