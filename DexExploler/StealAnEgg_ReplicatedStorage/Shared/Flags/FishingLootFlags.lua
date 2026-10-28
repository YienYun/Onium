-- Script path: ReplicatedStorage.Shared.Flags.FishingLootFlags
-- Decompile time: 1.63 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
local Environment = require(ReplicatedStorage.Shared.Modules.Environment)
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)

local function isEnabledByDefault() -- Line: 12 -- upvalues: Environment (val), RunService (val)
    return Environment.IsDevPlace() or Environment.IsTestPlace() or RunService:IsStudio()
end

local function flag(a1, a2, a3) -- Line: 16 -- upvalues: FastFlags (val) -- types: a1: string
    return FastFlags.Replicated(("Game.FishingLoot.%*"):format(a1), a2, a3)
end

return table.freeze({
    Enabled = FastFlags.Replicated(
        "Game.FishingLoot.Enabled",
        Asserts.Boolean,
        Environment.IsDevPlace() or Environment.IsTestPlace() or RunService:IsStudio()
    ),
    TokensWeight = FastFlags.Replicated("Game.FishingLoot.TokensWeight", Asserts.Range(0, 1000000), 76.5667),
    EggWeight = FastFlags.Replicated("Game.FishingLoot.EggWeight", Asserts.Range(0, 1000000), 20),
    MutationWeight = FastFlags.Replicated("Game.FishingLoot.MutationWeight", Asserts.Range(0, 1000000), 3.3333),
    PetWeight = FastFlags.Replicated("Game.FishingLoot.PetWeight", Asserts.Range(0, 1000000), 0.1),
    TokensMin = FastFlags.Replicated("Game.FishingLoot.TokensMin", Asserts.IntegerRange(1, 1000000), 18),
    TokensMax = FastFlags.Replicated("Game.FishingLoot.TokensMax", Asserts.IntegerRange(1, 1000000), 45),
    MutationAmount = FastFlags.Replicated("Game.FishingLoot.MutationAmount", Asserts.IntegerRange(1, 100), 1),
    PetId = FastFlags.Replicated("Game.FishingLoot.PetId", Asserts.String, "Ghost Fish"),
    LuckMax = FastFlags.Replicated("Game.FishingLoot.LuckMax", Asserts.Range(1, 100), 3),
    EggLuckMinRank = FastFlags.Replicated("Game.FishingLoot.EggLuckMinRank", Asserts.IntegerRange(1, 20), 8),
    EggZoneWeights = FastFlags.Replicated("Game.FishingLoot.EggZoneWeights", Asserts.Map(Asserts.String, Asserts.Range(0, 1000000)), {}),
})