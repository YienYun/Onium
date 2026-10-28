-- Script path: ReplicatedStorage.Data.LightVsDarkness
-- Decompile time: 6.68 ms

local EggCategory, Mutation, TeamEggCategories, v1, v2, v3
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Assets = require(ReplicatedStorage.Data.Assets)
local GuardAreaGeometry = require(ReplicatedStorage.Shared.Util.GuardAreaGeometry)
local LightVsDarknessEventFlags = require(ReplicatedStorage.Shared.Flags.LightVsDarknessEventFlags)
local Mutations = require(ReplicatedStorage.Shared.Modules.Mutations)
local Rings = ReplicatedStorage.Assets.Models:WaitForChild("Rings")
local u188 = ((Workspace:WaitForChild("World")):WaitForChild("Areas")):WaitForChild("GuardAreas")
local u212 = nil
local u191 = {
    RARITIES = {
        {
            Id = "Normal",
            Weight = 53,
            Points = 10,
            Model = "NormalRing",
            Radius = 0,
            SpinSpeed = 2.4,
        },
        {
            Id = "Charged",
            Weight = 30,
            Points = 50,
            Model = "ChargedRing",
            Radius = 0,
            SpinSpeed = 2,
        },
        {
            Id = "Secret",
            Weight = 12,
            Points = 250,
            Model = "SecretRing",
            Radius = 0,
            SpinSpeed = 1.7,
        },
        {
            Id = "Rainbow",
            Weight = 3,
            Points = 1000,
            Model = "RainbowRing",
            Radius = 0,
            SpinSpeed = 1.4,
        },
    },
}
local u215 = 0
local v4 = nil
local v5 = nil
for i, j in u191.RARITIES, v4, v5 do
    v1 = Rings:FindFirstChild(j.Model)
    v3 = ("Rings.%* must be a BasePart"):format(j.Model)
    assert(v1 and v1:IsA("BasePart"), v3)
    j.Radius = v1.Size.Y / 2
    u215 = u215 + j.Weight
end
u191.MILESTONES = {
    {Frame = "Milestone1", Rings = 100, Reward = "SpeedBoost15"},
    {
        Frame = "Milestone2",
        Rings = 800,
        Reward = "TeamEgg",
        Mutation = "Silver",
        TeamEggCategories = {Light = "Jellyfish", Darkness = "Dark Gargoyle"},
    },
    {Frame = "Milestone3", Rings = 1500, Reward = "Egg", EggCategory = "Ringlord"},
}
v4 = nil
v5 = nil
for k, n in u191.MILESTONES, v4, v5 do
    EggCategory = n.EggCategory
    v2 = true
    if EggCategory ~= nil then
        v2 = Assets.Directory[EggCategory] ~= nil
    end
    assert(v2, (("unknown milestone egg %*"):format(EggCategory)))
    TeamEggCategories = n.TeamEggCategories or {}
    v2 = nil
    v3 = nil
    for m, i5 in TeamEggCategories, v2, v3 do
        assert(Assets.Directory[i5] ~= nil, (("unknown milestone egg %*"):format(i5)))
    end
    Mutation = n.Mutation
    v2 = true
    if Mutation ~= nil then
        v2 = Mutations.IsKnown(Mutation)
    end
    assert(v2, (("unknown milestone mutation %*"):format(Mutation)))
end

function u191.MilestoneEggCategory(a1, a2) -- Line: 110 -- upvalues: u191 (val) -- types: a1: number, a2: string?
    local v1 = u191.MILESTONES[a1]
    local TeamEggCategories = v1.TeamEggCategories
    if TeamEggCategories == nil then
        return v1.EggCategory
    end
    if a2 ~= nil then
        return TeamEggCategories[a2]
    end
    return nil
end

function u191.MilestoneIcon(a1, a2) -- Line: 120 -- upvalues: u191 (val), Assets (val) -- types: a1: number, a2: string?
    if u191.MILESTONES[a1].Reward:match("SpeedBoost") then
        return "rbxassetid://78137530993637"
    end
    local v1 = u191.MilestoneEggCategory(a1, a2)
    if v1 == nil then
        return nil
    end
    local Egg = Assets.Directory[v1].Egg
    if Egg.Icon ~= "" then
        return Egg.Icon
    end
    return Assets.BaseConfig.Egg.Icon
end

function u191.MilestoneQuantity(a1) -- Line: 135
    -- upvalues: u191 (val), LightVsDarknessEventFlags (val)
    if u191.MILESTONES[a1].Reward ~= "SpeedBoost" then
        return nil
    end
    local v1 = math.max(math.floor((LightVsDarknessEventFlags.MilestoneSpeedBoostSeconds:Get()) / 60 + 0.5), 1)
    return (("%* %*"):format(v1, if v1 ~= 1 then "mins" else "min"))
end

function u191.MilestoneKey(a1) -- Line: 145 -- types: a1: number
    return (("Milestone%*"):format(a1))
end

function u191.MilestoneAttribute(a1) -- Line: 149 -- upvalues: u191 (val) -- types: a1: number
    return (("Lvd%*"):format((u191.MilestoneKey(a1))))
end

function u191.Template(a1) -- Line: 153 -- upvalues: Rings (val), u191 (val) -- types: a1: number
    local v1 = Rings:FindFirstChild(u191.RARITIES[a1].Model)
    local v2 = ("Ring template %* missing"):format(a1)
    assert(v1 and v1:IsA("BasePart"), v2)
    return v1
end

function u191.RollRarity(a1) -- Line: 159 -- upvalues: u215 (ref), u191 (val) -- types: a1: userdata
    local v1 = a1:NextNumber(0, u215)
    for i, j in u191.RARITIES do
        v1 = v1 - j.Weight
        if v1 <= 0 then
            return i
        end
    end
    return #u191.RARITIES
end

function u191.Zones() -- Line: 171 -- upvalues: u212 (ref), GuardAreaGeometry (val), u188 (val)
    local v1 = u212
    if v1 then
        return v1
    end
    v1 = GuardAreaGeometry.ReadAreaBounds(u188)
    table.sort(v1, function(a1, a2) -- Line: 177
        return a1.Bounds.Position.X < a2.Bounds.Position.X
    end)
    u212 = v1
    return v1
end

function u191.ZoneIndexAt(a1) -- Line: 185 -- upvalues: u191 (val), GuardAreaGeometry (val) -- types: a1: vector
    local v1
    local v2 = 1
    local v3 = (1 / 0)
    for i, j in (u191.Zones()) do
        if GuardAreaGeometry.IsWithinFootprint(j.Bounds, a1) then
            return i
        end
        v1 = math.abs(j.Bounds.Position.X - a1.X)
        if v1 < v3 then
            v2 = i
        end
    end
    return v2
end

function u191.EncodeRings(a1) -- Line: 202 -- types: a1: table
    local Rarity, X, Y, Z, v1
    local v2 = buffer.create(#a1 * 13)
    local v3 = 0
    for i, j in a1 do
        X = j.X
        buffer.writef32(v2, v3, X)
        v1 = v3 + 4
        Y = j.Y
        buffer.writef32(v2, v1, Y)
        v1 = v3 + 8
        Z = j.Z
        buffer.writef32(v2, v1, Z)
        v1 = v3 + 12
        Rarity = j.Rarity
        buffer.writeu8(v2, v1, Rarity)
        v3 = v3 + 13
    end
    return v2
end

function u191.DecodeRings(a1) -- Line: 215 -- types: a1: buffer
    local v1, v2, v3
    local v4 = {}
    for i = 1, buffer.len(a1) // 13 do
        v2 = (i - 1) * 13
        v3 = {X = buffer.readf32(a1, v2)}
        v1 = v2 + 4
        v3.Y = buffer.readf32(a1, v1)
        v1 = v2 + 8
        v3.Z = buffer.readf32(a1, v1)
        v1 = v2 + 12
        v3.Rarity = buffer.readu8(a1, v1)
        v4[i] = v3
    end
    return v4
end

return u191