-- Script path: ReplicatedStorage.Shared.Eggs.EggActionMovement
-- Decompile time: 2.41 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local u16 = t.intersection(t.numberMinExclusive((-1 / 0)), t.numberMaxExclusive((1 / 0)))

local function u17(a1) -- Line: 12 -- upvalues: u16 (val)
    if typeof(a1) ~= "CFrame" then
        return false
    end
    for i, v in ipairs({a1:GetComponents()}) do
        if not u16(v) then
            return false
        end
    end
    return true
end

local BulkPartMotion = require(ReplicatedStorage.Client.BulkPartMotion)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u26 = {}
local u27 = {}

local function newModelState(a1) -- Line: 43
    -- upvalues: t (val), Trove (val), BulkPartMotion (val), u26 (val), u27 (val)
    local PrimaryPart = a1.PrimaryPart
    t.strict(t.instanceIsA("BasePart"))(PrimaryPart)
    PrimaryPart.Anchored = true
    local v1 = Trove.new()
    local u15 = {}
    for i, j in {PrimaryPart} do
        u15[i] = (BulkPartMotion.Register(j))
    end
    v1:Add(function() -- Line: 55 -- upvalues: u15 (val)
        for i, j in u15 do
            j:Destroy()
        end
    end)
    local v2 = {Parts = {PrimaryPart}, Components = u15, Trove = v1}
    u26[a1] = v2
    v1:Connect(a1.Destroying, function() -- Line: 67 -- upvalues: u27 (upval), a1 (val)
        u27.Remove(a1)
    end)
    return v2
end

function u27.SetPivot(a1, a2) -- Line: 76
    -- upvalues: t (val), u17 (val), u26 (val), newModelState (val)
    local v1
    t.strict(t.instanceIsA("Model"))(a1)
    t.strict(u17)(a2)
    local v2 = u26[a1] or newModelState(a1)
    local Pivot = a1:GetPivot()
    for i, j in v2.Parts do
        v1 = Pivot:ToObjectSpace(j.CFrame)
        v2.Components[i]:SetCFrame(a2 * v1)
    end
end

function u27.Remove(a1) -- Line: 88 -- upvalues: t (val), u26 (val) -- types: a1: userdata
    t.strict(t.instanceIsA("Model"))(a1)
    local v1 = u26[a1]
    if v1 == nil then
        return
    end
    u26[a1] = nil
    v1.Trove:Destroy()
end

return u27