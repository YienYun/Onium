-- Script path: ReplicatedStorage.Packages._Index.roblox_testez@0.4.1.testez.TestBootstrap
-- Decompile time: 3.50 ms

local TestPlanner = require(script.Parent.TestPlanner)
local TestRunner = require(script.Parent.TestRunner)
local TextReporter = require(script.Parent.Reporters.TextReporter)
local v1 = {}

local function stripSpecSuffix(a1) -- Line: 11
    return (a1:gsub("%.spec$", ""))
end

local function isSpecScript(a1) -- Line: 14
    return a1:IsA("ModuleScript") and a1.Name:match("%.spec$")
end

local function getPath(a1, a2) -- Line: 18
    local v1 = a2 or game
    local v2 = {}
    local Parent = a1
    if Parent.Name == "init.spec" then
        Parent = Parent.Parent
    end
    while Parent ~= nil do
        if Parent == v1 then
            break
        end
        table.insert(v2, (Parent.Name:gsub("%.spec$", "")))
        Parent = Parent.Parent
    end
    table.insert(v2, (v1.Name:gsub("%.spec$", "")))
    return v2
end

local function toStringPath(a1) -- Line: 38
    local v1 = ""
    local v2 = true
    for i, v in ipairs(a1) do
        v1 = if not v2 then v .. " " .. v1 else v
    end
    return v1
end

function v1.getModulesImpl(a1, a2, a3, a4) -- Line: 52 -- upvalues: getPath (val)
    local v1 = a3 or {}
    local v2 = a4 or a2
    local v3 = v2:IsA("ModuleScript") and v2.Name:match("%.spec$")
    if v3 then
        v3 = require(v2)
        local v4 = getPath(v2, a2)
        local v5 = ""
        local v6 = true
        for i, v in ipairs(v4) do
            v5 = if not v6 then v .. " " .. v5 else v
        end
        table.insert(v1, {method = v3, path = v4, pathStringForSorting = v5:lower()})
    end
end

function v1:getModules(a2) -- Line: 72
    local v1 = {}
    self:getModulesImpl(a2, v1)
    for i, v in ipairs(a2:GetDescendants()) do
        self:getModulesImpl(a2, v1, v)
    end
    return v1
end

function v1.run(a1, a2, a3, a4) -- Line: 99 -- upvalues: TextReporter (val), TestPlanner (val), TestRunner (val)
    local v1 = a3 or TextReporter
    local v2 = a4 or {}
    local v3 = v2.showTimingInfo or false
    local testNamePattern = v2.testNamePattern
    local extraEnvironment = v2.extraEnvironment or {}
    if type(a2) ~= "table" then
        error(("Bad argument #1 to TestBootstrap:run. Expected table, got %s"):format((typeof(a2))), 2)
    end
    local v4 = tick()
    local v5 = {}
    for i, v in ipairs(a2) do
        for i2, i3 in ipairs((a1:getModules(v))) do
            table.insert(v5, i3)
        end
    end
    local v6 = tick()
    local v7 = TestPlanner.createPlan(v5, testNamePattern, extraEnvironment)
    v5 = tick()
    local v8 = TestRunner.runPlan(v7)
    v7 = tick()
    v1.report(v8)
    local v9 = tick()
    if v3 then
        local v10 = {
            ("Took %f seconds to locate test modules"):format(v6 - v4),
            ("Took %f seconds to create test plan"):format(v5 - v6),
            ("Took %f seconds to run tests"):format(v7 - v5),
            (("Took %f seconds to report tests"):format(v9 - v7)),
        }
        print(table.concat(v10, "\n"))
    end
    return v8
end

return v1