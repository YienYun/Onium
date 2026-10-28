-- Script path: ReplicatedStorage.Data.Rift
-- Decompile time: 8.10 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local EggSkins = require(ReplicatedStorage.Data.EggSkins)
local RiftFlags = require(ReplicatedStorage.Shared.Flags.RiftFlags)
local u19 = {
    {
        Id = "Verdant",
        DisplayName = "Riftborn",
        EggSkin = "Riftborn",
        Weight = 55,
        From = "Volcano",
        To = "Abyss Ocean",
        Pets = {
            {AssetId = "Rift Eye", Weight = 45},
            {AssetId = "Voidmaw", Weight = 36},
            {AssetId = "Ventinal", Weight = 15},
            {AssetId = "Wendigo", Weight = 3.5},
            {AssetId = "World Eater", Weight = 0.5},
        },
    },
    {
        Id = "Umbral",
        DisplayName = "Riftbeasts",
        EggSkin = "Riftbeasts",
        Weight = 40,
        From = "Prehistoric",
        To = "Cosmic",
        Pets = {
            {AssetId = "Void Angler", Weight = 45},
            {AssetId = "Riftwing", Weight = 36},
            {AssetId = "Dreadclaw", Weight = 15},
            {AssetId = "Mawbreaker", Weight = 3.5},
            {AssetId = "Void Serpent", Weight = 0.5},
        },
    },
    {
        Id = "Radiant",
        DisplayName = "Shattered Rift",
        EggSkin = "ShatteredRift",
        Weight = 5,
        From = "Cherry Blossom",
        To = "Titan Temple",
        Pets = {
            {AssetId = "Shardling", Weight = 45},
            {AssetId = "Shattered Ram", Weight = 36},
            {AssetId = "Shardwing", Weight = 15},
            {AssetId = "Shattered Drake", Weight = 3.5},
            {AssetId = "Shattered Colossus", Weight = 0.5},
        },
    },
}
local u41 = {
    {Biomes = 4, TargetSpawn = 30, SpawnSpread = 9},
    {Biomes = 3, TargetSpawn = 16, SpawnSpread = 9},
    {Biomes = 2, TargetSpawn = 14, SpawnSpread = 9},
}
local u45 = {}
for i, j in u19 do
    u45[j.Id] = j
end
local u56 = {}

function u56.RotationSeconds() -- Line: 93 -- upvalues: RiftFlags (val)
    return RiftFlags.RotationSeconds:Get()
end

u56.RequirementCount = #u41
u56.RecipeSlots = u41
u56.Banners = u19

function u56.GetBanner(a1) -- Line: 100 -- upvalues: u45 (val) -- types: a1: string
    return u45[a1]
end

function u56.BannerIds() -- Line: 104 -- upvalues: u19 (val)
    local v1 = {}
    for i, j in u19 do
        table.insert(v1, j.Id)
    end
    return v1
end

function u56.GetBannerDisplayName(a1) -- Line: 112 -- upvalues: u45 (val) -- types: a1: string
    local v1 = u45[a1]
    if v1 then
        return v1.DisplayName
    end
    return a1
end

function u56.GetBannerEggSkin(a1) -- Line: 118 -- upvalues: u45 (val) -- types: a1: string
    local v1 = u45[a1]
    if v1 then
        return v1.EggSkin
    end
    return nil
end

function u56.GetBannerEggIcon(a1) -- Line: 123 -- upvalues: EggSkins (val), u56 (val) -- types: a1: string
    local v1 = EggSkins.Get(u56.GetBannerEggSkin(a1))
    if v1 then
        return v1.Icon
    end
    return nil
end

function u56.GetBannerWeight(a1) -- Line: 130 -- upvalues: RiftFlags (val), u45 (val) -- types: a1: string
    local v1 = RiftFlags.BannerWeights:Get()[a1]
    if v1 ~= nil then
        return v1
    end
    v1 = u45[a1]
    if v1 then
        return v1.Weight
    end
    return 0
end

function u56.GetBannerRange(a1) -- Line: 140 -- upvalues: u45 (val), RiftFlags (val) -- types: a1: string
    local v1 = u45[a1]
    local v2 = ("unknown rift banner %*"):format(a1)
    assert(v1 ~= nil, v2)
    local v3 = RiftFlags.BannerRanges:Get()[a1]
    local From = if v3 == nil then v1.From else if v3.From == nil then v1.From else v3.From
    if v3 ~= nil and v3.To ~= nil then
        return From, v3.To
    end
    return From, v1.To
end

function u56.GetRecipeSlot(a1) -- Line: 153 -- upvalues: u41 (val), RiftFlags (val) -- types: a1: number
    local v1 = u41[a1]
    local v2 = ("the Rift has no recipe slot %*"):format(a1)
    assert(v1 ~= nil, v2)
    local v3 = (RiftFlags.SlotOverrides:Get())[tostring(a1)]
    if v3 == nil then
        return v1
    end
    local v4 = {}
    local Biomes = v3.Biomes or v1.Biomes
    v4.Biomes = Biomes
    local TargetSpawn = v3.TargetSpawn or v1.TargetSpawn
    v4.TargetSpawn = TargetSpawn
    local SpawnSpread = v3.SpawnSpread or v1.SpawnSpread
    v4.SpawnSpread = SpawnSpread
    return v4
end

function u56.PetOverrideKey(a1, a2) -- Line: 167 -- types: a1: string, a2: string
    return a1 .. ":" .. a2
end

function u56.GetPetWeight(a1, a2) -- Line: 171
    -- upvalues: RiftFlags (val), u56 (val), u45 (val)
    local v1 = (RiftFlags.PetWeights:Get())[u56.PetOverrideKey(a1, a2)]
    if v1 ~= nil then
        return v1
    end
    v1 = u45[a1]
    if v1 == nil then
        return 0
    end
    for i, j in v1.Pets do
        if j.AssetId == a2 then
            return j.Weight
        end
    end
    return 0
end

function u56.BannerContainsPet(a1, a2) -- Line: 189 -- upvalues: u45 (val) -- types: a1: string, a2: string
    local v1 = u45[a1]
    if v1 == nil then
        return false
    end
    for i, j in v1.Pets do
        if j.AssetId == a2 then
            return true
        end
    end
    return false
end

function u56.RollPet(a1, a2) -- Line: 202 -- upvalues: u45 (val), u56 (val) -- types: a1: string, a2: userdata
    local v1, v2
    local v3 = u45[a1]
    if v3 == nil then
        return nil
    end
    local v4 = {}
    local v5 = 0
    for i, j in v3.Pets do
        v1 = u56.GetPetWeight(a1, j.AssetId)
        v4[i] = v1
        if v1 > 0 then
            v5 = v5 + v1
        end
    end
    if v5 <= 0 then
        return nil
    end
    local v6 = a2:NextNumber() * v5
    v5 = 0
    local AssetId = nil
    for k, n in v3.Pets do
        v2 = v4[k]
        if not (v2 <= 0) then
            v5 = v5 + v2
            AssetId = n.AssetId
            if v6 <= v5 then
                return n.AssetId
            end
        end
    end
    return AssetId
end

local function petsByWeight(a1) -- Line: 239 -- upvalues: u45 (val), u56 (val) -- types: a1: string
    local v1
    local v2 = u45[a1]
    if v2 == nil then
        return {}
    end
    local v3 = {}
    for i, j in v2.Pets do
        v1 = u56.GetPetWeight(a1, j.AssetId)
        if v1 > 0 then
            table.insert(v3, {AssetId = j.AssetId, Weight = v1})
        end
    end
    table.sort(v3, function(a1, a2) -- Line: 251
        if a1.Weight == a2.Weight then
            return a1.AssetId < a2.AssetId
        end
        return a2.Weight < a1.Weight
    end)
    return v3
end

function u56.ChasePetId(a1) -- Line: 260 -- upvalues: petsByWeight (val) -- types: a1: string
    local v1 = petsByWeight(a1)
    local v2 = v1[#v1]
    if v2 then
        return v2.AssetId
    end
    return nil
end

function u56.PityPool(a1) -- Line: 268 -- upvalues: petsByWeight (val), RiftFlags (val) -- types: a1: string
    local v1 = petsByWeight(a1)
    local v2 = RiftFlags.PityWeights:Get()
    local v3 = math.min(#v2, #v1)
    local v4 = {}
    for i = 1, v3 do
        table.insert(v4, {AssetId = v1[#v1 - v3 + i].AssetId, Weight = v2[i]})
    end
    return v4
end

function u56.RollPityPet(a1, a2) -- Line: 280 -- upvalues: u56 (val) -- types: a1: string, a2: userdata
    local v1 = u56.PityPool(a1)
    local v2 = 0
    for i, j in v1 do
        if 0 < j.Weight then
            v2 = v2 + j.Weight
        end
    end
    if v2 <= 0 then
        return u56.ChasePetId(a1)
    end
    local v3 = a2:NextNumber() * v2
    v2 = 0
    local AssetId = nil
    for k, n in v1 do
        if not (n.Weight <= 0) then
            v2 = v2 + n.Weight
            AssetId = n.AssetId
            if v3 <= v2 then
                return n.AssetId
            end
        end
    end
    return AssetId
end

function u56.CurrentPeriod() -- Line: 312 -- upvalues: Workspace (val), u56 (val)
    return (math.floor((Workspace:GetServerTimeNow()) / (u56.RotationSeconds())))
end

function u56.BannerIdForPeriod(a1) -- Line: 316 -- upvalues: u19 (val), u56 (val) -- types: a1: number
    local v1 = 0
    for i, j in u19 do
        v1 = v1 + u56.GetBannerWeight(j.Id)
    end
    if v1 <= 0 then
        return u19[1].Id
    end
    local v2 = Random.new(a1):NextNumber() * v1
    v1 = 0
    for k, n in u19 do
        v1 = v1 + u56.GetBannerWeight(n.Id)
        if v2 <= v1 then
            return n.Id
        end
    end
    return u19[#u19].Id
end

function u56.CurrentBannerId() -- Line: 336 -- upvalues: u56 (val)
    return u56.BannerIdForPeriod(u56.CurrentPeriod())
end

function u56.SecondsUntilRotation() -- Line: 340 -- upvalues: Workspace (val), u56 (val)
    local ServerTimeNow = Workspace:GetServerTimeNow()
    local v1 = u56.RotationSeconds()
    return v1 - ServerTimeNow % v1
end

return table.freeze(u56)