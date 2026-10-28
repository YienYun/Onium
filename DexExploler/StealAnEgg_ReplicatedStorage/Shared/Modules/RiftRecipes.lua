-- Script path: ReplicatedStorage.Shared.Modules.RiftRecipes
-- Decompile time: 13.77 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Areas = require(ReplicatedStorage.Data.Areas)
local Log = require(ReplicatedStorage.Packages.Log)
local RollWeighted = require(ReplicatedStorage.Shared.Utils.Numeric).RollWeighted
local Rift = require(ReplicatedStorage.Data.Rift)
local RiftFlags = require(ReplicatedStorage.Shared.Flags.RiftFlags)
local RiftZoneLadder = require(ReplicatedStorage.Shared.Modules.RiftZoneLadder)
local t = require(ReplicatedStorage.Packages.t)
local u37 = {Easy = "E", Medium = "M", Hard = "H", Excluded = "X"}
local u38 = {
    E = 1,
    M = 2,
    H = 3,
    X = 4,
    ["?"] = 5,
}
local u45 = Log.new()
local u48 = Random.new()
local u49 = {}

local function gaussian(a1, a2, a3) -- Line: 84 -- types: a1: number, a2: number, a3: number
    if not (a3 <= 0) then
        local v1 = a1 - a2
        return (math.exp(-(v1 * v1 / (a3 * 2 * a3))))
    end
    if a1 == a2 then
        return 1
    end
    return 0
end

function u49.ResolveConfig() -- Line: 92 -- upvalues: RiftFlags (val), Rift (val)
    local v1 = {}
    for i, j in RiftFlags.ExcludedPets:Get() do
        v1[j] = true
    end
    local v2 = {}
    local RequirementCount = Rift.RequirementCount
    for k = 1, RequirementCount do
        v2[k] = (Rift.GetRecipeSlot(k))
    end
    return {
        MinSpawnChance = RiftFlags.MinSpawnChance:Get(),
        MaxSpawnChance = RiftFlags.MaxSpawnChance:Get(),
        EasyBand = RiftFlags.EasyBand:Get(),
        MediumBand = RiftFlags.MediumBand:Get(),
        HardPenalty = RiftFlags.HardPenalty:Get(),
        ExtendBelow = RiftFlags.ExtendBelow:Get(),
        Slots = v2,
        RequireEasyPet = RiftFlags.RequireEasyPet:Get(),
        MaxEasyPets = RiftFlags.MaxEasyPets:Get(),
        MaxHardPets = RiftFlags.MaxHardPets:Get(),
        MaxNonEasyPets = RiftFlags.MaxNonEasyPets:Get(),
        AllowDuplicatePets = RiftFlags.AllowDuplicatePets:Get(),
        MaxRecipeAttempts = RiftFlags.MaxRecipeAttempts:Get(),
        Excluded = v1,
    }
end

function u49.GetDifficulty(a1, a2) -- Line: 119 -- types: a1: number, a2: table
    if not (a1 < a2.MinSpawnChance) and not (a2.MaxSpawnChance < a1) then
        if a2.EasyBand <= a1 then
            return "Easy"
        end
        if a2.MediumBand <= a1 then
            return "Medium"
        end
        return "Hard"
    end
    return "Excluded"
end

function u49.ZonePets(a1) -- Line: 133 -- upvalues: Areas (val) -- types: a1: string
    local v1 = {}
    local v2 = Areas.Directory[a1]
    if v2 == nil then
        return v1
    end
    for i, j in v2.DropTable do
        table.insert(v1, {AssetId = j[1], SpawnChance = j[2]})
    end
    return v1
end

function u49.SpawnChanceOf(a1) -- Line: 146 -- upvalues: Areas (val), u49 (val) -- types: a1: string
    local SpawnChance = nil
    local v1 = nil
    local v2 = nil
    local v3 = nil
    for i in Areas.Directory, v2, v3 do
        for j, k in u49.ZonePets(i) do
            if k.AssetId == a1 then
                if SpawnChance == nil or SpawnChance < k.SpawnChance then
                    SpawnChance = k.SpawnChance
                    v1 = i
                end
            end
        end
    end
    return SpawnChance, v1
end

function u49.IsZonePet(a1) -- Line: 160 -- upvalues: u49 (val) -- types: a1: string
    return u49.SpawnChanceOf(a1) ~= nil
end

function u49.IsEligible(a1, a2) -- Line: 164 -- upvalues: u49 (val) -- types: a1: table, a2: table
    if a2.Excluded[a1.AssetId] == true then
        return false
    end
    return u49.GetDifficulty(a1.SpawnChance, a2) ~= "Excluded"
end

function u49.DifficultyOf(a1, a2) -- Line: 171 -- upvalues: u49 (val) -- types: a1: string, a2: table?
    local v1 = u49.SpawnChanceOf(a1)
    if v1 == nil then
        return nil
    end
    return u49.GetDifficulty(v1, a2 or u49.ResolveConfig())
end

local function newContext(a1, a2) -- Line: 179
    -- upvalues: Rift (val), RiftZoneLadder (val), u49 (val)
    local v1, v2 = Rift.GetBannerRange(a1)
    local v3 = RiftZoneLadder.Get()
    local v4 = nil
    local v5 = nil
    local v6 = nil
    local v7 = nil
    for i, j in v3, v6, v7 do
        if j.Id == v1 then
            v4 = i
        end
        if j.Id == v2 then
            v5 = i
        end
    end
    v7 = ("Rift banner %* names an unknown From zone: %*"):format(v8, v1)
    assert(v4 ~= nil, v7)
    v7 = ("Rift banner %* names an unknown To zone: %*"):format(v8, v2)
    assert(v5 ~= nil, v7)
    v7 = ("Rift banner %* runs backwards (%* -> %*)"):format(v8, v1, v2)
    assert(v4 <= v5, v7)
    v2 = {}
    for k, n in v3 do
        v2[k] = (u49.ZonePets(n.Id))
    end
    return {
        BannerId = v8,
        Config = v9,
        Ladder = v3,
        Bottom = math.max(1, v4 - v9.ExtendBelow),
        Top = v5,
        PetsByRung = v2,
    }
end

local function buildSlotPool(a1, a2, a3) -- Line: 210 -- upvalues: u49 (val) -- types: a1: table, a2: number, a3: table
    local HardPenalty, SpawnChance_2, SpawnSpread, TargetSpawn, v1, v2, v3, v4, v5, v6, v7, v8, v9
    local Config = a1.Config
    local v10 = Config.Slots[a2]
    local v11 = math.max(a1.Bottom, a1.Top - (v10.Biomes - 1))
    local v12 = {}
    local Top_2 = a1.Top
    local v13, v14 = a1, a3
    for i = v11, Top_2 do
        v1 = v13.Ladder[i]
        v2 = v13.PetsByRung[i]
        v3 = nil
        v4 = nil
        for j, k in v2, v3, v4 do
            if u49.IsEligible(k, Config) then
                if Config.AllowDuplicatePets or not v14[k.AssetId] then
                    v5 = u49.GetDifficulty(k.SpawnChance, Config)
                    HardPenalty = if v5 ~= "Hard" then 1 else Config.HardPenalty
                    v7 = math.sqrt(k.SpawnChance)
                    SpawnChance_2 = k.SpawnChance
                    TargetSpawn = v10.TargetSpawn
                    SpawnSpread = v10.SpawnSpread
                    if not (SpawnSpread <= 0) then
                        v9 = SpawnChance_2 - TargetSpawn
                        v8 = math.exp(-(v9 * v9 / (SpawnSpread * 2 * SpawnSpread)))
                    else
                        v8 = if SpawnChance_2 ~= TargetSpawn then 0 else 1
                    end
                    v6 = v7 * v8 * HardPenalty
                    if v6 > 0 then
                        table.insert(v12, {
                            {
                                AssetId = k.AssetId,
                                SpawnChance = k.SpawnChance,
                                ZoneId = v1.Id,
                                ZoneIndex = i,
                                Difficulty = v5,
                            },
                            v6,
                        })
                    end
                end
            end
        end
    end
    return v12
end

local function isValidRecipe(a1, a2) -- Line: 249 -- types: a1: table, a2: table
    local Difficulty
    if #a1 ~= #a2.Slots then
        return false
    end
    local v1 = {Easy = 0, Medium = 0, Hard = 0, Excluded = 0}
    local v2 = {}
    local v3 = nil
    local v4 = nil
    local v5 = a2
    for i, j in a1, v3, v4 do
        if not v5.AllowDuplicatePets and v2[j.AssetId] then
            return false
        end
        v2[j.AssetId] = true
        Difficulty = j.Difficulty
        v1[Difficulty] = v1[Difficulty] + 1
    end
    if v5.RequireEasyPet and v1.Easy < 1 then
        return false
    end
    if v5.MaxEasyPets < v1.Easy or v5.MaxHardPets < v1.Hard or v5.MaxNonEasyPets < v1.Medium + v1.Hard then
        return false
    end
    return true
end

local function rollRecipe(a1, a2) -- Line: 277
    -- upvalues: RollWeighted (val), buildSlotPool (val), isValidRecipe (val)
    local v1, v2, v3, v4, v5
    local Config = a1.Config
    local MaxRecipeAttempts = Config.MaxRecipeAttempts
    local v6, v7 = a1, a2
    for i = 1, MaxRecipeAttempts do
        v2 = {}
        v3 = {}
        v4 = true
        v5 = #Config.Slots
        for j = 1, v5 do
            v1 = RollWeighted(buildSlotPool(v6, j, v3), v7)
            if v1 == nil then
                v4 = false
                break
            end
            table.insert(v2, v1)
            v3[v1.AssetId] = true
        end
        if v4 and isValidRecipe(v2, Config) then
            return v2
        end
    end
    return nil
end

function u49.GenerateRecipe(a1, a2, a3) -- Line: 299
    -- upvalues: t (val), u49 (val), newContext (val), rollRecipe (val), u48 (val)
    t.strict(t.string)(a1)
    local v1 = a3 or u49.ResolveConfig()
    local success, err = pcall(newContext, a1, v1)
    if not success then
        return nil, (tostring(err))
    end
    local v2 = rollRecipe(err, a2 or u48)
    if v2 == nil then
        return nil, (("no valid recipe for %* after %* attempts"):format(a1, v1.MaxRecipeAttempts))
    end
    return v2, nil
end

local function fallbackAssetIds(a1, a2, a3) -- Line: 319
    -- upvalues: newContext (val), u45 (val), u49 (val)
    local v1
    local success, err = pcall(newContext, a1, a3)
    if not success then
        (u45:AtError()):Log((("Rift fallback recipe unavailable for %*: %*"):format(a1, err)))
        return {}
    end
    local v2 = {}
    local Bottom = err.Bottom
    local Top = err.Top
    for i = Bottom, Top do
        for j, k in err.PetsByRung[i] do
            if u49.IsEligible(k, a3) then
                table.insert(v2, k.AssetId)
            end
        end
    end
    local v3 = {}
    for n = 1, (math.min(#a3.Slots, #v2)) do
        v1 = a2:NextInteger(1, #v2)
        table.insert(v3, v2[v1])
        table.remove(v2, v1)
    end
    return v3
end

function u49.RollAssetIds(a1, a2) -- Line: 343
    -- upvalues: t (val), u48 (val), u49 (val), RiftFlags (val), u45 (val), fallbackAssetIds (val)
    t.strict(t.string)(a1)
    local v1 = a2 or u48
    local v2 = u49.ResolveConfig()
    if RiftFlags.RecipesEnabled:Get() then
        local v3, v4 = u49.GenerateRecipe(a1, v1, v2)
        if v3 ~= nil then
            local v5 = {}
            for i, j in v3 do
                table.insert(v5, j.AssetId)
            end
            return v5
        end
        ;(u45:AtWarning()):Log((("Rift recipe engine fell back for %*: %*"):format(a1, v4)))
    end
    return (fallbackAssetIds(a1, v1, v2))
end

function u49.Describe(a1, a2) -- Line: 362 -- upvalues: u49 (val), u37 (val), u38 (val) -- types: a1: table, a2: table?
    local v1
    local v2 = a2 or u49.ResolveConfig()
    local v3 = {}
    local v4 = nil
    local v5 = nil
    for i, j in a1, v4, v5 do
        v1 = u49.DifficultyOf(j, v2)
        table.insert(v3, if not v1 then "?" else u37[v1])
    end
    table.sort(v3, function(a1, a2) -- Line: 369 -- upvalues: u38 (upval) -- types: a1: string, a2: string
        return u38[a1] < u38[a2]
    end)
    return table.concat(v3)
end

function u49.DescribeCandidates(a1) -- Line: 375 -- upvalues: u37 (val), u38 (val) -- types: a1: table
    local v1 = {}
    for i, j in a1 do
        table.insert(v1, u37[j.Difficulty])
    end
    table.sort(v1, function(a1, a2) -- Line: 380 -- upvalues: u38 (upval) -- types: a1: string, a2: string
        return u38[a1] < u38[a2]
    end)
    return table.concat(v1)
end

function u49.Simulate(a1, a2, a3) -- Line: 386
    -- upvalues: t (val), u49 (val), newContext (val), rollRecipe (val)
    local Bands, v1, v2, v3, v4
    t.strict(t.string)(a1)
    t.strict(t.numberPositive)(a2)
    local v5 = u49.ResolveConfig()
    local v6 = {
        Failures = 0,
        NonZonePicks = 0,
        Distinct = 0,
        PoolSize = 0,
        BannerId = a1,
        Runs = a2,
    }
    v6.Patterns = {}
    v6.SlotPicks = {}
    v6.Bands = {Easy = 0, Medium = 0, Hard = 0, Excluded = 0}
    local v7 = #v5.Slots
    for i = 1, v7 do
        v6.SlotPicks[i] = {}
    end
    local success, err = pcall(newContext, a1, v5)
    if not success then
        v6.Error = tostring(err)
        return v6
    end
    v6.PoolBottom = err.Ladder[err.Bottom].Id
    v6.PoolTop = err.Ladder[err.Top].Id
    local Bottom = err.Bottom
    local Top = err.Top
    for j = Bottom, Top do
        v1 = err.PetsByRung[j]
        v2 = nil
        v3 = nil
        for k, n in v1, v2, v3 do
            v7 = if v5.Excluded[n.AssetId] ~= true then u49.GetDifficulty(n.SpawnChance, v5) else "Excluded"
            Bands = v6.Bands
            Bands[v7] = Bands[v7] + 1
            v6.PoolSize = v6.PoolSize + 1
        end
    end
    v5 = if a3 == nil then Random.new() else Random.new(a3)
    local v8 = {}
    for m = 1, a2 do
        v2 = rollRecipe(err, v5)
        if v2 ~= nil then
            v3 = u49.DescribeCandidates(v2)
            v6.Patterns[v3] = (v6.Patterns[v3] or 0) + 1
            v3 = {}
            for i5, i6 in v2 do
                v4 = v6.SlotPicks[i5]
                v4[i6.AssetId] = (v4[i6.AssetId] or 0) + 1
                table.insert(v3, i6.AssetId)
                if not u49.IsZonePet(i6.AssetId) then
                    v6.NonZonePicks = v6.NonZonePicks + 1
                end
            end
            table.sort(v3)
            v8[(table.concat(v3, "|"))] = true
        else
            v6.Failures = v6.Failures + 1
        end
    end
    for i7 in v8 do
        v6.Distinct = v6.Distinct + 1
    end
    return v6
end

return table.freeze(u49)