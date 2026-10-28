-- Script path: ReplicatedStorage.Shared.Modules.BatController.Config
-- Decompile time: 0.74 ms

local Workspace = game:GetService("Workspace")
local u5 = {
    Range = 15,
    HitTolerance = 2,
    TargetViewSamplePadding = 0.05,
    MaximumTargetViewAge = 0.35,
    DragonEggEventHitboxScalar = 2.5,
    DragonEggEventActiveAttribute = "DragonEggEventActive",
}

function u5.GetHitboxScalar() -- Line: 14 -- upvalues: Workspace (val), u5 (ref)
    if Workspace:GetAttribute(u5.DragonEggEventActiveAttribute) ~= true then
        return 1
    end
    return u5.DragonEggEventHitboxScalar
end

u5 = ((require((game:GetService("ReplicatedStorage")).Shared.Flags.BalanceConfig)).Bind(
    "Game.Balance.BatCombat",
    u5,
    {Range = true, HitTolerance = true, DragonEggEventHitboxScalar = true},
    false
))
return u5