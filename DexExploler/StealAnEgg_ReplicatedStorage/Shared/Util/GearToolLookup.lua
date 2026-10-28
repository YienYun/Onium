-- Script path: ReplicatedStorage.Shared.Util.GearToolLookup
-- Decompile time: 1.56 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local GearTools = ReplicatedStorage.GearTools
local u13 = table.freeze({})
local u16 = t.strict(t.string)

local function toolNamed(a1, a2) -- Line: 16 -- types: a1: userdata?, a2: string
    local v1 = false
    if a1 ~= nil then
        v1 = a1.Name == a2
    end
    if v1 and a1:IsA("Tool") then
        return a1
    end
    return nil
end

return function(a1) -- Line: 21 -- upvalues: u16 (val), GearTools (val), u13 (val) -- types: a1: string
    local v1, v2, v3
    u16(a1)
    local v4 = GearTools:FindFirstChild(a1, true)
    local v5 = false
    if v4 ~= nil then
        v5 = v4.Name == a1
    end
    v5 = if (if not v5 then nil else if not v4:IsA("Tool") then nil else v4) == nil then GearTools:GetDescendants() else u13
    local v6 = nil
    local v7 = nil
    for i, j in v5, v6, v7 do
        v2 = v1
        if not v2 then
            v3 = false
            if j ~= nil then
                v3 = j.Name == a1
            end
            v2 = if not v3 then nil else if not j:IsA("Tool") then nil else j
        end
        v1 = v2
    end
    return v1
end