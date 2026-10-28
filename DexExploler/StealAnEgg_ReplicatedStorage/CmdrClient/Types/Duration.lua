-- Script path: ReplicatedStorage.CmdrClient.Types.Duration
-- Decompile time: 2.79 ms

local Util = require(script.Parent.Parent.Shared.Util)
local u7 = {
    Years = 31556926,
    Months = 2629744,
    Weeks = 604800,
    Days = 86400,
    Hours = 3600,
    Minutes = 60,
    Seconds = 1,
}
local v1 = {}
for k, v in pairs(u7) do
    table.insert(v1, k)
end
local u25 = Util.MakeFuzzyFinder(v1)

local function stringToSecondDuration(a1) -- Line: 19 -- upvalues: u25 (val), u7 (val)
    if a1 ~= nil and a1 ~= "" then
        local v1, v2, v3
        local v4 = tonumber(a1)
        if v4 and v4 == 0 then
            return 0, 0, true
        end
        local v5 = (a1:gsub("-?%d+%a+", "")):match("-?%d+")
        if v5 then
            return nil, (tonumber(v5)), true
        end
        v5 = nil
        local v6 = nil
        for i in a1:gmatch("-?%d+%a+") do
            v1, v2 = i:match("(-?%d+)(%a+)")
            v6 = v1
            v3 = v2
            v4 = u25(v3)
            if #v4 == 0 then
                return nil, (tonumber(v6))
            end
            if v5 == nil then
                v5 = 0
            end
            v5 = v5 + (if v3:lower() ~= "m" then u7[v4[1]] else 60) * tonumber(v6)
        end
        if v5 == nil then
            return nil
        end
        return v5, (tonumber(v6))
    end
    return nil
end

local function mapUnits(a1, a2, a3, a4) -- Line: 58
    local v1
    local v2 = a4 or 1
    local v3 = {}
    for k, v in pairs(a1) do
        if a3 ~= 1 then
            v3[k] = a2 .. v:sub(v2)
        else
            v1 = #v - 1
            v3[k] = a2 .. v:sub(v2, v1)
        end
    end
    return v3
end

local u29 = {}

function u29.Transform(a1) -- Line: 72 -- upvalues: stringToSecondDuration (val)
    return a1, stringToSecondDuration(a1)
end

function u29.Validate(a1, a2) -- Line: 76
    return a2 ~= nil
end

function u29.Autocomplete(a1, a2, a3, a4, a5) -- Line: 80 -- upvalues: u25 (val), mapUnits (val)
    local v1
    if not a4 and not a5 then
        if a2 ~= nil then
            v1 = a1:match("^.*-?%d+(%a+)%s?$")
            table.sort((mapUnits(u25(v1), a1, a3, #v1 + 1)))
        end
        return {}
    end
    v1 = not (a4 ~= true) and u25("") or a5
    if a4 == true then
        return (mapUnits(v1, a1, a3))
    end
    return (mapUnits(v1, a1, (a1:match("^.*(%a+)$"):len()) + 1))
end

function u29.Parse(a1, a2) -- Line: 104
    return a2
end

return function(a1) -- Line: 109 -- upvalues: u29 (val), Util (val)
    a1:RegisterType("duration", u29)
    a1:RegisterType("durations", (Util.MakeListableType(u29)))
end