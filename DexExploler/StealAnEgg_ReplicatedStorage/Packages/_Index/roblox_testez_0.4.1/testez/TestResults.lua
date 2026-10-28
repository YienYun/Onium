-- Script path: ReplicatedStorage.Packages._Index.roblox_testez@0.4.1.testez.TestResults
-- Decompile time: 2.23 ms

local TestEnum = require(script.Parent.TestEnum)
local u5 = {
    [TestEnum.TestStatus.Success] = "+",
    [TestEnum.TestStatus.Failure] = "-",
    [TestEnum.TestStatus.Skipped] = "~",
}
local u15 = {}
u15.__index = u15

function u15.new(a1) -- Line: 25 -- upvalues: u15 (val)
    local v1 = {
        successCount = 0,
        failureCount = 0,
        skippedCount = 0,
        planNode = a1,
        children = {},
        errors = {},
    }
    setmetatable(v1, u15)
    return v1
end

function u15.createNode(a1) -- Line: 43
    return {planNode = a1, children = {}, errors = {}}
end

function u15:visitAllNodes(a2, a3) -- Line: 57
    for i, v in ipairs((a3 or self).children) do
        a2(v)
        self:visitAllNodes(a2, v)
    end
end

function u15:visualize(a2, a3) -- Line: 70 -- upvalues: TestEnum (val), u5 (val)
    local v1, v2, v3
    local v4 = a3 or 0
    local v5 = {}
    for i, v in ipairs((a2 or self).children) do
        if v.planNode.type ~= TestEnum.NodeType.It then
            v3 = ("%s%s"):format((" "):rep(3 * v4), v.planNode.phrase or "")
            if v.status then
                v3 = v3 .. (" (%s)"):format(v.status)
            end
            table.insert(v5, v3)
            if #v.children > 0 then
                v2 = v4 + 1
                table.insert(v5, (v6:visualize(v, v2)))
            end
        else
            v3 = u5[v.status] or "?"
            v1 = ("%s[%s] %s"):format((" "):rep(3 * v4), v3, v.planNode.phrase)
            if v.messages and #v.messages > 0 then
                v1 = v1 .. "\n " .. ((" "):rep(3 * v4)) .. table.concat(v.messages, "\n " .. (" "):rep(3 * v4))
            end
            table.insert(v5, v1)
        end
    end
    return table.concat(v5, "\n")
end

return u15