-- Script path: ReplicatedStorage.Shared.Types.Sakura
-- Decompile time: 1.14 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Eggs = require(ReplicatedStorage.Shared.Types.Eggs)
local t = require(ReplicatedStorage.Packages.t)
local v1 = t.interface({Uid = t.string, Egg = Eggs.SchemaValidation.SerializedSavedEgg})
local v2 = {
    Egg = {blank = false, check = t.union(t.literal(false), v1)},
    Unlocked = {blank = false, check = t.boolean},
    TutorialSeen = {blank = false, check = t.boolean},
    Deposited = {blank = 0, check = t.number},
    LuckBoost = {blank = 0, check = t.number},
    Uses = {blank = 0, check = t.number},
    CostResetAt = {blank = 0, check = t.number},
    TotalMutations = {blank = 0, check = t.number},
}
local v3 = {}
local u44 = {}
for i, j in v2 do
    v3[i] = j.check
    u44[i] = j.blank
end
table.freeze(u44)
return {
    IncubatorEgg = v1,
    State = t.interface(v3),
    MutateResult = t.interface({
        Uid = t.string,
        Egg = Eggs.SchemaValidation.SerializedSavedEgg,
        Mutation = t.string,
    }),
    Blank = function() -- Line: 66 -- upvalues: u44 (val)
        return (table.clone(u44))
    end,
}