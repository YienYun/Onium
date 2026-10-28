-- Script path: ReplicatedStorage.Shared.Flags.ShrineFusionFlags
-- Decompile time: 3.60 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)

local function bounded(a1, a2) -- Line: 6 -- upvalues: Asserts (val) -- types: a1: number, a2: number
    return function(a1_2) -- Line: 7 -- upvalues: Asserts (upval), a1 (val), a2 (val)
        Asserts.FiniteNonNegative(a1_2)
        local v1 = false
        if a1 <= a1_2 then
            v1 = a1_2 <= a2
        end
        assert(v1, "Shrine fusion flag out of range")
        return a1_2
    end
end

local freeze = table.freeze
local v1 = {
    Enabled = FastFlags.Replicated("Game.ShrineFusion.Enabled", Asserts.Boolean, true),
    Recipes = FastFlags.Replicated("Game.ShrineFusion.Recipes", Asserts.Map(Asserts.String, Asserts.Map(Asserts.String, Asserts.String)), {
        Divine = {Light = "ArchAngel", Dark = "World Burner", Fused = "Aetheron"},
        Eternal = {Light = "Pegasus", Dark = "Skeleton Horse", Fused = "Equinox"},
        Enchanted = {Whale = "Royal Skywhale", Lion = "Cosmic Lion", Fused = "World Spirit"},
        Void = {Fish = "Ghost Fish", Pumpkin = "Voidseer Pumpkin", Fused = "Cursed Fish"},
    }),
}
local Replicated_2 = FastFlags.Replicated
local u39 = 1
local u40 = 60
v1.RitualSeconds = Replicated_2("Game.ShrineFusion.RitualSeconds", function(a1) -- Line: 7 -- upvalues: Asserts (val), u39 (val), u40 (val)
    Asserts.FiniteNonNegative(a1)
    local v1 = false
    if u39 <= a1 then
        v1 = a1 <= u40
    end
    assert(v1, "Shrine fusion flag out of range")
    return a1
end, 5)
local Replicated_3 = FastFlags.Replicated
local Map_2 = Asserts.Map
local String_2 = Asserts.String
local u48 = 1
local u49 = 60
v1.ShrineRitualSeconds = Replicated_3("Game.ShrineFusion.ShrineRitualSeconds", Map_2(String_2, function(a1) -- Line: 7 -- upvalues: Asserts (val), u48 (val), u49 (val)
    Asserts.FiniteNonNegative(a1)
    local v1 = false
    if u48 <= a1 then
        v1 = a1 <= u49
    end
    assert(v1, "Shrine fusion flag out of range")
    return a1
end), {Enchanted = 15, Void = 18})
local Replicated_4 = FastFlags.Replicated
local u56 = 1
local u57 = 120
v1.RetrySeconds = Replicated_4("Game.ShrineFusion.RetrySeconds", function(a1) -- Line: 7 -- upvalues: Asserts (val), u56 (val), u57 (val)
    Asserts.FiniteNonNegative(a1)
    local v1 = false
    if u56 <= a1 then
        v1 = a1 <= u57
    end
    assert(v1, "Shrine fusion flag out of range")
    return a1
end, 5)
v1.EggInventoryLimit = FastFlags.Replicated("Game.ShrineFusion.EggInventoryLimit", Asserts.IntegerPositive, 115)
v1.AllowStolenDNA = FastFlags.Replicated("Game.ShrineFusion.AllowStolenDNA", Asserts.Boolean, false)
v1.PreserveMutations = FastFlags.Replicated("Game.ShrineFusion.PreserveMutations", Asserts.Boolean, true)
v1.PreservePersonality = FastFlags.Replicated("Game.ShrineFusion.PreservePersonality", Asserts.Boolean, true)
v1.PreserveInputScale = FastFlags.Replicated("Game.ShrineFusion.PreserveInputScale", Asserts.Boolean, true)
v1.RewardNeverEarnsLess = FastFlags.Replicated("Game.ShrineFusion.RewardNeverEarnsLess", Asserts.Boolean, true)
local Replicated_5 = FastFlags.Replicated
local Map_3 = Asserts.Map
local String_3 = Asserts.String
local u95 = 0.01
local u96 = 100
v1.FixedRewardScale = Replicated_5("Game.ShrineFusion.FixedRewardScale", Map_3(String_3, function(a1) -- Line: 7 -- upvalues: Asserts (val), u95 (val), u96 (val)
    Asserts.FiniteNonNegative(a1)
    local v1 = false
    if u95 <= a1 then
        v1 = a1 <= u96
    end
    assert(v1, "Shrine fusion flag out of range")
    return a1
end), {Divine = 1, Eternal = 1, Enchanted = 1, Void = 1})
local Replicated_6 = FastFlags.Replicated
local Map_4 = Asserts.Map
local String_4 = Asserts.String
local u105 = 0.01
local u106 = 100
v1.RewardScaleMultiplier = Replicated_6("Game.ShrineFusion.RewardScaleMultiplier", Map_4(String_4, function(a1) -- Line: 7 -- upvalues: Asserts (val), u105 (val), u106 (val)
    Asserts.FiniteNonNegative(a1)
    local v1 = false
    if u105 <= a1 then
        v1 = a1 <= u106
    end
    assert(v1, "Shrine fusion flag out of range")
    return a1
end), {Divine = 1, Eternal = 1, Enchanted = 1, Void = 1})
return freeze(v1)