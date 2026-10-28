-- Script path: ReplicatedStorage.CmdrClient.Types.Primitives
-- Decompile time: 6.82 ms

local Util = require(script.Parent.Parent.Shared.Util)
local u7 = {}

function u7.Validate(a1) -- Line: 4
    return a1 ~= nil
end

function u7.Parse(a1) -- Line: 8
    return (tostring(a1))
end

local u10 = {}

function u10.Transform(a1) -- Line: 14
    return (tonumber(a1))
end

function u10.Validate(a1) -- Line: 18
    return a1 ~= nil
end

function u10.Parse(a1) -- Line: 22
    return a1
end

local u14 = {}

function u14.Transform(a1) -- Line: 28
    return (tonumber(a1))
end

function u14.Validate(a1) -- Line: 32
    local v1 = false
    if a1 ~= nil then
        v1 = a1 == math.floor(a1)
    end
    return v1, "Only whole numbers are valid."
end

function u14.Parse(a1) -- Line: 36
    return a1
end

local u18 = {}

function u18.Transform(a1) -- Line: 42
    return (tonumber(a1))
end

function u18.Validate(a1) -- Line: 46
    local v1 = false
    if a1 ~= nil then
        v1 = false
        if a1 == math.floor(a1) then
            v1 = a1 > 0
        end
    end
    return v1, "Only positive whole numbers are valid."
end

function u18.Parse(a1) -- Line: 50
    return a1
end

local u22 = {}

function u22.Transform(a1) -- Line: 56
    return (tonumber(a1))
end

function u22.Validate(a1) -- Line: 60
    local v1 = false
    if a1 ~= nil then
        v1 = false
        if a1 == math.floor(a1) then
            v1 = a1 >= 0
        end
    end
    return v1, "Only non-negative whole numbers are valid."
end

function u22.Parse(a1) -- Line: 64
    return a1
end

local u26 = {}

function u26.Transform(a1) -- Line: 70
    return (tonumber(a1))
end

function u26.Validate(a1) -- Line: 74
    local v1 = false
    if a1 ~= nil then
        v1 = false
        if a1 == math.floor(a1) then
            v1 = false
            if a1 >= 0 then
                v1 = a1 <= 255
            end
        end
    end
    return v1, "Only bytes are valid."
end

function u26.Parse(a1) -- Line: 78
    return a1
end

local u30 = {}

function u30.Transform(a1) -- Line: 84
    return (tonumber(a1))
end

function u30.Validate(a1) -- Line: 88
    local v1 = false
    if a1 ~= nil then
        v1 = false
        if a1 == math.floor(a1) then
            v1 = false
            if a1 >= 0 then
                v1 = a1 <= 9
            end
        end
    end
    return v1, "Only digits are valid."
end

function u30.Parse(a1) -- Line: 92
    return a1
end

local u46 = Util.MakeDictionary({"true", "t", "yes", "y", "on", "enable", "enabled", "1", "+"})
local u58 = Util.MakeDictionary({"false", "f", "no", "n", "off", "disable", "disabled", "0", "-"})
local u63 = {
    Transform = function(a1) -- Line: 102
        return a1:lower()
    end,
    Validate = function(a1) -- Line: 106 -- upvalues: u46 (val), u58 (val)
        local v1 = true
        if u46[a1] == nil then
            v1 = u58[a1] ~= nil
        end
        return v1, "Please use true/yes/on or false/no/off."
    end,
    Parse = function(a1) -- Line: 110 -- upvalues: u46 (val), u58 (val)
        if u46[a1] then
            return true
        end
        if u58[a1] then
            return false
        end
        return nil
    end,
}
return function(a1) -- Line: 122
    -- upvalues: u7 (val), u10 (val), u14 (val), u18 (val), u22 (val), u26 (val), u30 (val), u63 (ref), Util (val)
    a1:RegisterType("string", u7)
    a1:RegisterType("number", u10)
    a1:RegisterType("integer", u14)
    a1:RegisterType("positiveInteger", u18)
    a1:RegisterType("nonNegativeInteger", u22)
    a1:RegisterType("byte", u26)
    a1:RegisterType("digit", u30)
    a1:RegisterType("boolean", u63)
    a1:RegisterType("strings", (Util.MakeListableType(u7)))
    a1:RegisterType("numbers", (Util.MakeListableType(u10)))
    a1:RegisterType("integers", (Util.MakeListableType(u14)))
    a1:RegisterType("positiveIntegers", (Util.MakeListableType(u18)))
    a1:RegisterType("nonNegativeIntegers", (Util.MakeListableType(u22)))
    a1:RegisterType("bytes", (Util.MakeListableType(u26)))
    a1:RegisterType("digits", (Util.MakeListableType(u30)))
    a1:RegisterType("booleans", (Util.MakeListableType(u63)))
end