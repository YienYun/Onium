-- Script path: ReplicatedStorage.Client.PlotUpgradeVisibility
-- Decompile time: 1.68 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlotState = require(ReplicatedStorage.Client.PlotState)
local t = require(ReplicatedStorage.Packages.t)
local v1 = {}

local function paintSubtree(a1, a2) -- Line: 16 -- types: a1: userdata, a2: boolean
    local v1 = a2
    for i, v in ipairs(a1:GetDescendants()) do
        if v:IsA("BasePart") then
            v.LocalTransparencyModifier = if not v1 then 1 else 0
        elseif v:IsA("SurfaceGui") then
            v.Enabled = v1
        elseif not v:IsA("BillboardGui") then
            if v:IsA("BillboardGui") and v.Name ~= "CanUpgrade" then
                v.Enabled = true
            end
        elseif not v1 then
            v.Enabled = false
        elseif v:IsA("BillboardGui") and v.Name ~= "CanUpgrade" then
            v.Enabled = true
        end
    end
end

function v1.Apply(a1, a2) -- Line: 34
    -- upvalues: t (val), PlotState (val), paintSubtree (val)
    local Parent, v1
    t.strict(t.string)(a1)
    t.strict(t.optional(t.boolean))(a2)
    local v2 = PlotState.ResolveFolder()
    local v3 = PlotState.ResolveLocalSlot()
    local v4 = if v3 == nil then nil else tostring(v3)
    local v5 = if v2 ~= nil then v2:GetDescendants() else {}
    local v6 = nil
    local v7 = nil
    local v8, v9 = a1, a2
    for i, j in v5, v6, v7 do
        Parent = j.Parent
        if j.Name == v8 and Parent ~= nil then
            v1 = false
            if v4 ~= nil then
                v1 = false
                if Parent.Name == v4 then
                    v1 = v9 ~= false
                end
            end
            paintSubtree(j, v1)
        end
    end
end

return v1