-- Script path: ReplicatedStorage.Shared.Flags.GameFlags
-- Decompile time: 1.38 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)

local function toggle(a1, a2) -- Line: 10 -- upvalues: FastFlags (val), Asserts (val) -- types: a1: string, a2: boolean
    return FastFlags.Replicated(a1, Asserts.Boolean, a2)
end

local function bounded(a1, a2, a3, a4) -- Line: 14
    -- upvalues: FastFlags (val), Asserts (val)
    return FastFlags.Replicated(a1, Asserts.Range(a2, a3), a4)
end

local function nonNegative(a1, a2) -- Line: 18
    -- upvalues: FastFlags (val), Asserts (val)
    return FastFlags.Replicated(a1, Asserts.FiniteNonNegative, a2)
end

local function wholeNumber(a1, a2) -- Line: 22
    -- upvalues: FastFlags (val), Asserts (val)
    return FastFlags.Replicated(a1, Asserts.IntegerNonNegative, a2)
end

return table.freeze({
    PetMounts = require(script.Parent.PetMountFlags),
    StorefrontOpen = FastFlags.Replicated("Game.Storefront.Open", Asserts.Boolean, true),
    OneTimeRepeatGuard = FastFlags.Replicated("Game.Storefront.OneTimeRepeatGuard", Asserts.Boolean, true),
    ClientSidePrompts = FastFlags.Replicated("Game.Storefront.ClientSidePrompts", Asserts.Boolean, false),
    SoundEffects = FastFlags.Replicated("Game.Audio.SoundEffects", Asserts.Boolean, true),
    WorldOverlaysHidden = FastFlags.Replicated("Game.World.OverlaysHidden", Asserts.Boolean, false),
    ForbiddenIslandEnabled = FastFlags.Replicated("Game.ForbiddenIsland.Enabled", Asserts.Boolean, true),
    GreatBloomEnabled = FastFlags.Replicated("Game.GreatBloom.Enabled", Asserts.Boolean, false),
    FriendBoostCap = FastFlags.Replicated("Game.FriendBoost.Cap", Asserts.IntegerNonNegative, 4),
    FriendBoostPercentPerFriend = FastFlags.Replicated("Game.FriendBoost.PercentPerFriend", Asserts.FiniteNonNegative, 10),
    PetUpdateSchedulingEnabled = FastFlags.Replicated("ClientPerformance.Pets.SchedulingEnabled", Asserts.Boolean, true),
    DistantPetUpdateDistance = FastFlags.Replicated("ClientPerformance.Pets.DistantUpdateDistance", Asserts.Range(128, 4096), 300),
    DistantPetUpdateInterval = FastFlags.Replicated("ClientPerformance.Pets.DistantUpdateInterval", Asserts.Range(0, 0.25), 0.1),
    HiddenPetUpdateInterval = FastFlags.Replicated("ClientPerformance.Pets.HiddenUpdateInterval", Asserts.Range(0, 0.25), 0.1),
})