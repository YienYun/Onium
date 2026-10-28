-- Script path: ReplicatedStorage.Shared.Util.ToolCooldown
-- Decompile time: 2.70 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local v1 = t.intersection(t.numberMinExclusive((-1 / 0)), t.numberMaxExclusive((1 / 0)))
local u18 = {
    {attribute = "CooldownEndTime", kind = "number", blank = 0},
    {attribute = "CooldownDuration", kind = "number", blank = 0},
    {attribute = "CooldownActive", kind = "boolean", blank = false},
}
local u24 = t.strict(v1)
local u30 = t.strict(t.instanceIsA("Tool"))
local u31 = {}

local function readyAtOf(a1) -- Line: 30 -- types: a1: userdata
    local Attribute = a1:GetAttribute("CooldownEndTime")
    if type(Attribute) == "number" then
        return Attribute
    end
    return nil
end

local function markIdle(a1) -- Line: 35 -- types: a1: userdata
    a1:SetAttribute("CooldownActive", false)
    a1:SetAttribute("CooldownDuration", 0)
    a1:SetAttribute("CooldownEndTime", 0)
end

function u31.PrimeTool(a1) -- Line: 41 -- upvalues: u30 (val), u18 (val) -- types: a1: userdata
    u30(a1)
    for i, j in u18 do
        if (typeof((a1:GetAttribute(j.attribute)))) ~= j.kind then
            a1:SetAttribute(j.attribute, j.blank)
        end
    end
end

function u31.IsRunning(a1) -- Line: 51 -- upvalues: u30 (val) -- types: a1: userdata
    local v1
    u30(a1)
    if not a1:GetAttribute("CooldownActive") then
        v1 = nil
    else
        local Attribute = a1:GetAttribute("CooldownEndTime")
        v1 = if type(Attribute) ~= "number" then nil else Attribute
    end
    local v2 = false
    if v1 ~= nil then
        v2 = workspace:GetServerTimeNow() < v1
    end
    return v2
end

function u31.SecondsRemaining(a1) -- Line: 58 -- upvalues: u30 (val), u31 (val) -- types: a1: userdata
    local v1
    u30(a1)
    if not u31.IsRunning(a1) then
        v1 = nil
    else
        local Attribute = a1:GetAttribute("CooldownEndTime")
        v1 = if type(Attribute) ~= "number" then nil else Attribute
    end
    if v1 == nil then
        return 0
    end
    return (math.max(0, v1 - (workspace:GetServerTimeNow())))
end

function u31.Begin(a1, a2) -- Line: 65 -- upvalues: u30 (val), u24 (val) -- types: a1: userdata, a2: number
    u30(a1)
    u24(a2)
    assert(a2 >= 0)
    local u19 = workspace:GetServerTimeNow() + a2
    a1:SetAttribute("CooldownDuration", a2)
    a1:SetAttribute("CooldownEndTime", u19)
    a1:SetAttribute("CooldownActive", true)
    task.delay(a2, function() -- Line: 75 -- upvalues: a1 (val), u19 (val)
        if a1 and a1.Parent and (a1:GetAttribute("CooldownEndTime")) == u19 then
            local v1 = a1
            v1:SetAttribute("CooldownActive", false)
            v1:SetAttribute("CooldownDuration", 0)
            v1:SetAttribute("CooldownEndTime", 0)
        end
    end)
end

function u31.Cancel(a1) -- Line: 83 -- upvalues: u30 (val) -- types: a1: userdata
    u30(a1)
    a1:SetAttribute("CooldownActive", false)
    a1:SetAttribute("CooldownDuration", 0)
    a1:SetAttribute("CooldownEndTime", 0)
end

return u31