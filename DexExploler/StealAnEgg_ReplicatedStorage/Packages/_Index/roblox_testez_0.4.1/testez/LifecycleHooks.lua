-- Script path: ReplicatedStorage.Packages._Index.roblox_testez@0.4.1.testez.LifecycleHooks
-- Decompile time: 2.15 ms

local TestEnum = require(script.Parent.TestEnum)
local u5 = {}
u5.__index = u5

function u5.new() -- Line: 6 -- upvalues: u5 (val)
    return (setmetatable({_stack = {}}, u5))
end

function u5.getBeforeEachHooks(a1) -- Line: 16 -- upvalues: TestEnum (val)
    local v1 = {}
    for i, v in ipairs(a1._stack) do
        for i2, i3 in ipairs(v[TestEnum.NodeType.BeforeEach]) do
            table.insert(v1, i3)
        end
    end
    return v1
end

function u5.getAfterEachHooks(a1) -- Line: 32 -- upvalues: TestEnum (val)
    local v1 = {}
    for i, v in ipairs(a1._stack) do
        for i2, i3 in ipairs(v[TestEnum.NodeType.AfterEach]) do
            table.insert(v1, 1, i3)
        end
    end
    return v1
end

function u5.popHooks(a1) -- Line: 48
    table.remove(a1._stack, #a1._stack)
end

function u5.pushHooksFrom(a1, a2) -- Line: 52 -- upvalues: TestEnum (val)
    assert(a2 ~= nil)
    local _stack = a1._stack
    local v1 = {}
    v1[TestEnum.NodeType.BeforeAll] = (a1:_getHooksOfType(a2.children, TestEnum.NodeType.BeforeAll))
    v1[TestEnum.NodeType.AfterAll] = (a1:_getHooksOfType(a2.children, TestEnum.NodeType.AfterAll))
    v1[TestEnum.NodeType.BeforeEach] = (a1:_getHooksOfType(a2.children, TestEnum.NodeType.BeforeEach))
    v1[TestEnum.NodeType.AfterEach] = (a1:_getHooksOfType(a2.children, TestEnum.NodeType.AfterEach))
    table.insert(_stack, v1)
end

function u5.getBeforeAllHooks(a1) -- Line: 66 -- upvalues: TestEnum (val)
    return a1._stack[#a1._stack][TestEnum.NodeType.BeforeAll]
end

function u5.getAfterAllHooks(a1) -- Line: 73 -- upvalues: TestEnum (val)
    return a1._stack[#a1._stack][TestEnum.NodeType.AfterAll]
end

function u5._getHooksOfType(a1, a2, a3) -- Line: 77
    local v1 = {}
    for i, v in ipairs(a2) do
        if v.type == a3 then
            table.insert(v1, v.callback)
        end
    end
    return v1
end

return u5