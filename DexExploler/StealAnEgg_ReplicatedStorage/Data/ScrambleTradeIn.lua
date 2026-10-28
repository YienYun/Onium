-- Script path: ReplicatedStorage.Data.ScrambleTradeIn
-- Decompile time: 14.43 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local EggSkins = require(ReplicatedStorage.Data.EggSkins)
local ScrambleTradeInFlags = require(ReplicatedStorage.Shared.Flags.ScrambleTradeInFlags)
local u19 = {
    {
        Id = "Biohazard",
        DisplayName = "Biohazard Pets",
        EggSkin = "Biohazard",
        Weight = 42.5,
        From = "Cosmic",
        To = "Cherry Blossom",
        Pets = {
            {AssetId = "Toxic Rat", Weight = 45},
            {AssetId = "Radcoon", Weight = 36},
            {AssetId = "Toucax", Weight = 15},
            {AssetId = "Nuceodille", Weight = 3.5},
            {AssetId = "Nuclear Mantis", Weight = 0.5},
        },
    },
    {
        Id = "Experimental",
        DisplayName = "Experimental Pets",
        EggSkin = "Experimental",
        Weight = 35.5,
        From = "Cherry Blossom",
        To = "Titan Temple",
        Pets = {
            {AssetId = "Wheel Hamster", Weight = 45},
            {AssetId = "Stacked Turtle", Weight = 36},
            {AssetId = "Three Headed Chicken", Weight = 15},
            {AssetId = "Eyeball Crab", Weight = 3.5},
            {AssetId = "Dreadstinger", Weight = 0.5},
        },
    },
    {
        Id = "UnstableDNA",
        DisplayName = "Unstable DNA",
        EggSkin = "UnstableDNA",
        Weight = 22,
        From = "Titan Temple",
        To = "Light Dark",
        Pets = {
            {AssetId = "Frogfly", Weight = 45},
            {AssetId = "Spiderpig", Weight = 36},
            {AssetId = "Sharkodile", Weight = 15},
            {AssetId = "Rhinobear", Weight = 3.5},
            {AssetId = "Octophant", Weight = 0.5},
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
local u56 = {RotationOverrideAttribute = "ScrambleTradeInRotationOverride"}

function u56.RotationSeconds() -- Line: 79 -- upvalues: ScrambleTradeInFlags (val)
    return ScrambleTradeInFlags.RotationSeconds:Get()
end

u56.RequirementCount = #u41
u56.RecipeSlots = u41
u56.Banners = u19

function u56.GetBanner(a1) -- Line: 86 -- upvalues: u45 (val) -- types: a1: string
    return u45[a1]
end

function u56.BannerIds() -- Line: 90 -- upvalues: u19 (val)
    local v1 = {}
    for i, j in u19 do
        table.insert(v1, j.Id)
    end
    return v1
end

function u56.GetBannerDisplayName(a1) -- Line: 98 -- upvalues: u45 (val) -- types: a1: string
    local v1 = u45[a1]
    if v1 then
        return v1.DisplayName
    end
    return a1
end

function u56.GetBannerEggSkin(a1) -- Line: 103 -- upvalues: u45 (val) -- types: a1: string
    local v1 = u45[a1]
    if v1 then
        return v1.EggSkin
    end
    return nil
end

function u56.GetBannerEggIcon(a1) -- Line: 108 -- upvalues: EggSkins (val), u56 (val) -- types: a1: string
    local v1 = EggSkins.Get(u56.GetBannerEggSkin(a1))
    if v1 then
        return v1.Icon
    end
    return nil
end

local function effectiveBannerWeights() -- Line: 113 -- upvalues: ScrambleTradeInFlags (val), u19 (val)
    local Weight
    local v1 = ScrambleTradeInFlags.BannerWeights:Get()
    local v2 = {}
    local v3 = 0
    local v4 = nil
    local v5 = nil
    for i, j in u19, v4, v5 do
        Weight = v1[j.Id] or j.Weight
        v2[j.Id] = Weight
        v3 = v3 + Weight
    end
    if v3 <= 0 then
        for i6, i7 in u19 do
            v2[i7.Id] = i7.Weight
        end
        return v2
    end
    for k, n in u19 do
        if v3 < v2[n.Id] * 2 then
            for m, i5 in u19 do
                v2[i5.Id] = i5.Weight
            end
            return v2
        end
    end
    return v2
end

function u56.GetBannerWeight(a1) -- Line: 137 -- upvalues: effectiveBannerWeights (val) -- types: a1: string
    return effectiveBannerWeights()[a1] or 0
end

function u56.GetBannerRange(a1) -- Line: 141 -- upvalues: u45 (val), ScrambleTradeInFlags (val) -- types: a1: string
    local v1 = u45[a1]
    local v2 = ("unknown rift banner %*"):format(a1)
    assert(v1 ~= nil, v2)
    local v3 = ScrambleTradeInFlags.BannerRanges:Get()[a1]
    local From = if v3 == nil then v1.From else if v3.From == nil then v1.From else v3.From
    if v3 ~= nil and v3.To ~= nil then
        return From, v3.To
    end
    return From, v1.To
end

function u56.GetRecipeSlot(a1) -- Line: 154 -- upvalues: u41 (val), ScrambleTradeInFlags (val) -- types: a1: number
    local v1 = u41[a1]
    local v2 = ("the Rift has no recipe slot %*"):format(a1)
    assert(v1 ~= nil, v2)
    local v3 = (ScrambleTradeInFlags.SlotOverrides:Get())[tostring(a1)]
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

function u56.PetOverrideKey(a1, a2) -- Line: 168 -- types: a1: string, a2: string
    return a1 .. ":" .. a2
end

function u56.GetPetWeight(a1, a2) -- Line: 172
    -- upvalues: ScrambleTradeInFlags (val), u56 (val), u45 (val)
    local v1 = (ScrambleTradeInFlags.PetWeights:Get())[u56.PetOverrideKey(a1, a2)]
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

function u56.BannerContainsPet(a1, a2) -- Line: 190 -- upvalues: u45 (val) -- types: a1: string, a2: string
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

function u56.RollPet(a1, a2) -- Line: 203 -- upvalues: u45 (val), u56 (val) -- types: a1: string, a2: userdata
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

function u56.ChasePetId(a1) -- Line: 239 -- upvalues: u45 (val) -- types: a1: string
    local v1 = u45[a1]
    local v2 = v1 and v1.Pets[#v1.Pets]
    if v2 then
        return v2.AssetId
    end
    return nil
end

function u56.PityPool(a1) -- Line: 245 -- upvalues: u56 (val) -- types: a1: string
    local v1 = u56.ChasePetId(a1)
    if v1 then
        return {{Weight = 1, AssetId = v1}}
    end
    return {}
end

function u56.RollPityPet(a1, a2) -- Line: 250 -- upvalues: u56 (val) -- types: a1: string, a2: userdata
    return u56.ChasePetId(a1)
end

local function rotationOverride() -- Line: 254 -- upvalues: Workspace (val), u56 (val), u45 (val)
    local Attribute = Workspace:GetAttribute(u56.RotationOverrideAttribute)
    if typeof(Attribute) ~= "string" then
        return nil, nil
    end
    local v1, v2 = string.match(Attribute, "^([%d%.]+)|([%w]+)$")
    local v3 = tonumber(v1)
    if v3 ~= nil and not (v3 <= 0) and u45[v2] ~= nil then
        return v3, v2
    end
    return nil, nil
end

function u56.CurrentPeriod() -- Line: 267 -- upvalues: u56 (val), Workspace (val), u45 (val)
    local v1
    local v2 = u56.RotationSeconds()
    local ServerTimeNow = Workspace:GetServerTimeNow()
    local Attribute = Workspace:GetAttribute(u56.RotationOverrideAttribute)
    if typeof(Attribute) == "string" then
        local v3, v4 = string.match(Attribute, "^([%d%.]+)|([%w]+)$")
        local v5 = tonumber(v3)
        v1 = if v5 == nil then nil else if v5 <= 0 then nil else if u45[v4] ~= nil then v5 else nil
    else
        v1 = nil
    end
    if v1 ~= nil and v1 <= ServerTimeNow then
        return (math.floor(v1 / v2)) + math.floor((ServerTimeNow - v1) / v2)
    end
    return (math.floor(ServerTimeNow / v2))
end

local u84 = {}
local u85 = ""
local u86 = -1
local u87 = 0

function u56.BannerIdForPeriod(a1) -- Line: 282
    -- upvalues: u56 (val), u19 (val), Workspace (val), u45 (val), u85 (ref), u84 (val), u87 (ref), u86 (ref)
    local v1, v2, v3, v4, v5, v6, v7, v8, v9
    local v10 = u56.RotationSeconds()
    local v11 = {
        u56.GetBannerWeight(u19[1].Id),
        u56.GetBannerWeight(u19[2].Id),
        (u56.GetBannerWeight(u19[3].Id)),
    }
    local Attribute = Workspace:GetAttribute(u56.RotationOverrideAttribute)
    if typeof(Attribute) == "string" then
        local v12
        v9, v12 = string.match(Attribute, "^([%d%.]+)|([%w]+)$")
        v8 = tonumber(v9)
        if v8 == nil or v8 <= 0 then
            v6 = nil
            v7 = nil
        elseif u45[v12] ~= nil then
            v6 = v8
            v7 = v12
        else
            v6 = nil
            v7 = nil
        end
    else
        v6 = nil
        v7 = nil
    end
    v8 = if v6 == nil then nil else math.floor(v6 / v10)
    v9 = string.format("%d:%.9g:%.9g:%.9g:%s:%s", v10, v11[1], v11[2], v11[3], tostring(v6), (tostring(v7)))
    if v9 ~= u85 then
        u85 = v9
        table.clear(u84)
        u87 = math.floor((DateTime.fromUniversalTime(2026, 9, 1, 0, 0, 0)).UnixTimestamp / v10)
        u86 = u87 - 1
    end
    if a1 < u87 then
        return u19[a1 % #u19 + 1].Id
    end
    for i = u86 + 1, a1 do
        v9 = Random.new(i)
        if v8 == nil then
            if i ~= u87 then
                v2 = table.find(u56.BannerIds(), u84[i - 1])
                v3 = {}
                if v2 ~= 1 then
                    table.insert(v3, 1)
                end
                if v2 ~= 2 then
                    table.insert(v3, 2)
                end
                if v2 ~= 3 then
                    table.insert(v3, 3)
                end
                v4 = v3[1]
                v5 = v3[2]
                v3 = v11[v4] + v11[v5]
                v1 = if not (v3 <= 0) then if not ((v9:NextNumber()) < v11[v4] / v3) then v5 else v4 else v4
            else
                v6 = v11[1] + v11[2] + v11[3]
                v10 = v9:NextNumber() * v6
                v1 = if not (v10 < v11[1]) then if not (v10 < v11[1] + v11[2]) then 3 else 2 else 1
            end
        elseif i == v8 then
            v1 = table.find(u56.BannerIds(), v7)
        elseif i ~= u87 then
            v2 = table.find(u56.BannerIds(), u84[i - 1])
            v3 = {}
            if v2 ~= 1 then
                table.insert(v3, 1)
            end
            if v2 ~= 2 then
                table.insert(v3, 2)
            end
            if v2 ~= 3 then
                table.insert(v3, 3)
            end
            v4 = v3[1]
            v5 = v3[2]
            v3 = v11[v4] + v11[v5]
            v1 = if not (v3 <= 0) then if not ((v9:NextNumber()) < v11[v4] / v3) then v5 else v4 else v4
        else
            v6 = v11[1] + v11[2] + v11[3]
            v10 = v9:NextNumber() * v6
            v1 = if not (v10 < v11[1]) then if not (v10 < v11[1] + v11[2]) then 3 else 2 else 1
        end
        u84[i] = u19[v1].Id
    end
    math.max(u86, a1)
    return u84[a1]
end

function u56.CurrentBannerId() -- Line: 330 -- upvalues: u56 (val)
    return u56.BannerIdForPeriod(u56.CurrentPeriod())
end

function u56.SecondsUntilRotation() -- Line: 334 -- upvalues: Workspace (val), u56 (val), u45 (val)
    local v1
    local ServerTimeNow = Workspace:GetServerTimeNow()
    local v2 = u56.RotationSeconds()
    local Attribute = Workspace:GetAttribute(u56.RotationOverrideAttribute)
    if typeof(Attribute) == "string" then
        local v3, v4 = string.match(Attribute, "^([%d%.]+)|([%w]+)$")
        local v5 = tonumber(v3)
        v1 = if v5 == nil then nil else if v5 <= 0 then nil else if u45[v4] ~= nil then v5 else nil
    else
        v1 = nil
    end
    if v1 ~= nil and v1 <= ServerTimeNow then
        return v2 - (ServerTimeNow - v1) % v2
    end
    return v2 - ServerTimeNow % v2
end

return (table.freeze(u56))