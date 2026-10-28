-- Script path: ReplicatedStorage.Packages._Index.roblox_testez@0.4.1.testez.ExpectationContext
-- Decompile time: 1.41 ms

local Expectation = require(script.Parent.Expectation)
local checkMatcherNameCollisions = Expectation.checkMatcherNameCollisions

local function copy(a1) -- Line: 4
    local v1 = {}
    for k, v in pairs(a1) do
        v1[k] = v
    end
    return v1
end

local u7 = {}
u7.__index = u7

function u7.new(a1) -- Line: 17 -- upvalues: u7 (val)
    local v1
    local v2 = {}
    if not a1 then
        v1 = {}
    else
        v1 = {}
        for k, v in pairs(a1._extensions) do
            v1[k] = v
        end
        if not v1 then
            v1 = {}
        end
    end
    v2._extensions = v1
    return (setmetatable(v2, u7))
end

function u7.startExpectationChain(a1, ...) -- Line: 25 -- upvalues: Expectation (val)
    return (Expectation.new(...)):extend(a1._extensions)
end

function u7:extend(a2) -- Line: 29 -- upvalues: checkMatcherNameCollisions (val)
    local v1 = self
    for k, v in pairs(a2) do
        assert(v1._extensions[k] == nil, (string.format("Cannot reassign %q in expect.extend", k)))
        assert(checkMatcherNameCollisions(k), (string.format("Cannot overwrite matcher %q; it already exists", k)))
        v1._extensions[k] = v
    end
end

return u7