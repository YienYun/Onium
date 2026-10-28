-- Script path: ReplicatedStorage.UserGenerated.Concurrency.Observable
-- Decompile time: 1.10 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DeepEquals = require(ReplicatedStorage.UserGenerated.Collections.DeepEquals)
local Bindable = require(ReplicatedStorage.UserGenerated.Concurrency.Bindable)
local u23 = table.freeze({
    __index = table.freeze({
        Get = function(a1) -- Line: 45
            return a1.Value
        end,
        Set = function(a1, a2) -- Line: 60 -- upvalues: DeepEquals (val)
            if a1.Assertion then
                a2 = a1.Assertion(a2)
            end
            local Value = a1.Value
            a1.Value = a2
            if not DeepEquals(a2, Value) then
                a1.Changed:Fire(a2, Value)
            end
            return Value
        end,
    }),
})
return table.freeze({
    new = function(a1, a2) -- Line: 79 -- upvalues: Bindable (val), u23 (val) -- types: a1: function
        assert(type(a1) == "function")
        local v1 = a1(a2)
        local v2 = {Changed = Bindable.new(), Assertion = a1, Value = v1}
        v2.Readonly = v2
        return (setmetatable(v2, u23))
    end,
    Unasserted = function(a1) -- Line: 92 -- upvalues: Bindable (val), u23 (val)
        local v1 = {Changed = Bindable.new(), Value = a1}
        v1.Readonly = v1
        return (setmetatable(v1, u23))
    end,
})