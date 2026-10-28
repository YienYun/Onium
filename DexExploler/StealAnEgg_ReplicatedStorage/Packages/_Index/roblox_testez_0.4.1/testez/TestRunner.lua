-- Script path: ReplicatedStorage.Packages._Index.roblox_testez@0.4.1.testez.TestRunner
-- Decompile time: 3.83 ms

local TestEnum = require(script.Parent.TestEnum)
local TestSession = require(script.Parent.TestSession)
local LifecycleHooks = require(script.Parent.LifecycleHooks)
local u15 = {environment = {}}

local function wrapExpectContextWithPublicApi(a1) -- Line: 19
    return (setmetatable({
        extend = function(...) -- Line: 21 -- upvalues: a1 (val)
            a1:extend(...)
        end,
    }, {
        __call = function(a1_2, ...) -- Line: 25 -- upvalues: a1 (val)
            return a1:startExpectationChain(...)
        end,
    }))
end

function u15.runPlan(a1) -- Line: 35 -- upvalues: TestSession (val), LifecycleHooks (val), TestEnum (val), u15 (val)
    local v1 = TestSession.new(a1)
    local v2 = LifecycleHooks.new()
    v1.hasFocusNodes = #a1:findNodes(function(a1) -- Line: 39 -- upvalues: TestEnum (upval)
        return a1.modifier == TestEnum.NodeModifier.Focus
    end) > 0
    u15.runPlanNode(v1, a1, v2)
    return v1:finalize()
end

function u15.runPlanNode(a1, a2, a3) -- Line: 54
    -- upvalues: u15 (val), wrapExpectContextWithPublicApi (val), TestEnum (val)
    local v1, v2

    local function runCallback(a1_2, a2) -- Line: 55
        -- upvalues: u15 (upval), wrapExpectContextWithPublicApi (upval), a1 (val)
        local u44 = true
        local u45 = nil
        _G.__TESTEZ_RUNNING_TEST__ = true
        local u6 = a2 or ""
        local v1 = getfenv(a1_2)
        for k, v in pairs(u15.environment) do
            v1[k] = v
        end

        function v1.fail(a1) -- Line: 71 -- upvalues: u44 (ref), u45 (ref), u6 (ref)
            if a1 == nil then
                a1 = "fail() was called."
            end
            u44 = false
            u45 = u6 .. debug.traceback(tostring(a1), 2)
        end

        v1.expect = wrapExpectContextWithPublicApi(a1:getExpectationContext())
        local u37 = a1:getContext()
        local success, result = xpcall(function() -- Line: 84 -- upvalues: a1_2 (val), u37 (val)
            a1_2(u37)
        end, function(a1) -- Line: 86 -- upvalues: u6 (ref)
            return u6 .. debug.traceback(tostring(a1), 2)
        end)
        if not success then
            u44 = false
            u45 = result
        end
        _G.__TESTEZ_RUNNING_TEST__ = nil
        return u44, u45
    end

    local function runNode(a1) -- Line: 102 -- upvalues: a3 (val), runCallback (val)
        local v1, v2, v3, v4
        for i, v in ipairs(a3:getBeforeEachHooks()) do
            v1, v2 = runCallback(v, "beforeEach hook: ")
            if not v1 then
                return false, v2
            end
        end
        local v5, v6 = runCallback(a1.callback)
        for i2, i3 in ipairs(a3:getAfterEachHooks()) do
            v3, v4 = runCallback(i3, "afterEach hook: ")
            if not v3 then
                if not v5 then
                    return false, v6 .. "\nWhile cleaning up the failed test another error was found:\n" .. v4
                end
                return false, v4
            end
        end
        if not v5 then
            return false, v6
        end
        return true, nil
    end

    a3:pushHooksFrom(a2)
    local v3 = false
    for i, v in ipairs(a3:getBeforeAllHooks()) do
        v1, v2 = runCallback(v, "beforeAll hook: ")
        if not v1 then
            a1:addDummyError("beforeAll", v2)
            v3 = true
        end
    end
    if not v3 then
        for i2, i3 in ipairs(a2.children) do
            if i3.type == TestEnum.NodeType.It then
                a1:pushNode(i3)
                if not a1:shouldSkip() then
                    v1, v2 = runNode(i3)
                    if not v1 then
                        a1:setError(v2)
                    else
                        a1:setSuccess()
                    end
                else
                    a1:setSkipped()
                end
                a1:popNode()
            elseif i3.type == TestEnum.NodeType.Describe then
                a1:pushNode(i3)
                u15.runPlanNode(a1, i3, a3)
                if not i3.loadError then
                    a1:setStatusFromChildren()
                else
                    a1:setError("Error during planning: " .. i3.loadError)
                end
                a1:popNode()
            end
        end
    end
    for i4, j in ipairs(a3:getAfterAllHooks()) do
        v1, v2 = runCallback(j, "afterAll hook: ")
        if not v1 then
            a1:addDummyError("afterAll", v2)
        end
    end
    a3:popHooks()
end

return u15