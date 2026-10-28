-- Script path: ReplicatedStorage.Controllers.Game.HalloweenDimensionController.WorldEvents.WaterTint
-- Decompile time: 4.48 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
require(ReplicatedStorage.Packages.Trove)
local u18 = TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
local u23 = setmetatable({}, {__mode = "k"})
local v1 = {}

local function isWater(a1) -- Line: 25 -- types: a1: userdata
    if not a1:IsA("BasePart") then
        return false
    end
    local v1 = true
    if a1.Material ~= Enum.Material.Water then
        v1 = a1:GetAttribute("TerrainRole") == "Basin"
    end
    return v1
end

local function propertyOf(a1) -- Line: 33 -- types: a1: userdata
    if a1:IsA("BasePart") then
        local v1
        if a1:IsA("BasePart") then
            v1 = true
            if a1.Material ~= Enum.Material.Water then
                v1 = a1:GetAttribute("TerrainRole") == "Basin"
            end
        else
            v1 = false
        end
        if v1 then
            return "Color"
        end
        return nil
    end
    if not a1:IsA("Decal") then
        return nil
    end
    local Parent = a1.Parent
    if Parent ~= nil then
        local v2
        if Parent:IsA("BasePart") then
            v2 = true
            if Parent.Material ~= Enum.Material.Water then
                v2 = Parent:GetAttribute("TerrainRole") == "Basin"
            end
        else
            v2 = false
        end
        if v2 then
            return "Color3"
        end
    end
    return nil
end

local function originalOf(a1, a2) -- Line: 44 -- upvalues: u23 (val) -- types: a1: userdata, a2: string
    local v1 = u23[a1]
    if v1 == nil then
        v1 = a1[a2]
        u23[a1] = v1
    end
    return v1
end

local function shade(a1, a2) -- Line: 53 -- types: a1: userdata, a2: userdata
    local v1
    local v2, v3, v4 = a2:ToHSV()
    _, _, v1 = a1:ToHSV()
    return Color3.fromHSV(v2, v3, (math.min(v4 * v1 / 0.5, 1)))
end

function v1.Bind(a1, a2, a3, a4) -- Line: 63
    -- upvalues: u23 (val), TweenService (val), u18 (val)
    local u4 = {}

    local function apply(a1) -- Line: 66
        -- upvalues: u4 (val), u23 (upval), a3 (val), a4 (val), TweenService (upval), u18 (upval)
        local v1, v2, v3
        if u4[a1] ~= nil then
            return
        end
        if a1:IsA("BasePart") then
            if a1:IsA("BasePart") then
                v2 = true
                if a1.Material ~= Enum.Material.Water then
                    v2 = a1:GetAttribute("TerrainRole") == "Basin"
                end
            else
                v2 = false
            end
            v1 = if not v2 then nil else "Color"
        elseif not a1:IsA("Decal") then
            v1 = nil
        else
            local Parent = a1.Parent
            if Parent == nil then
                v1 = nil
            else
                if Parent:IsA("BasePart") then
                    v3 = true
                    if Parent.Material ~= Enum.Material.Water then
                        v3 = Parent:GetAttribute("TerrainRole") == "Basin"
                    end
                else
                    v3 = false
                end
                v1 = if not v3 then nil else "Color3"
            end
        end
        if v1 == nil then
            return
        end
        v2 = u23[a1]
        if v2 == nil then
            v2 = a1[v1]
            u23[a1] = v2
        end
        if v1 ~= "Color" then
            v3 = a4
        else
            local v4
            local v5, v6, v7 = a3:ToHSV()
            _, _, v4 = v2:ToHSV()
            v3 = Color3.fromHSV(v5, v6, (math.min(v7 * v4 / 0.5, 1)))
        end
        u4[a1] = v1
        TweenService:Create(a1, u18, {[v1] = v3}):Play()
    end

    for i, j in a1:GetDescendants() do
        apply(j)
    end
    a2:Connect(a1.DescendantAdded, apply)
    a2:Add(function() -- Line: 84 -- upvalues: u4 (val), TweenService (upval), u18 (upval), u23 (upval)
        local v1, v2, v3
        for i, j in u4 do
            if i.Parent ~= nil then
                v1 = TweenService
                v2 = u18
                v3 = {}
                v3[j] = u23[i]
                v1:Create(i, v2, v3):Play()
            end
        end
    end)
end

return v1