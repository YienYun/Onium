-- Script path: ReplicatedStorage.Shared.Util.PlayerEarningsBoost
-- Decompile time: 1.81 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local BossMasteryFlags = require(ReplicatedStorage.Shared.Flags.BossMasteryFlags)
local u15 = {
    DURATION_SECONDS = 900,
    EXPIRES_AT_ATTRIBUTE = "EarningsBoostExpiresAt",
    BONUS_MULTIPLIER_ATTRIBUTE = "EarningsBonusMultiplier",
    BONUS_EXPIRES_AT_ATTRIBUTE = "EarningsBonusExpiresAt",
}

function u15.GetConfiguredMultiplier() -- Line: 24 -- upvalues: BossMasteryFlags (val)
    return BossMasteryFlags.CashBoosterMultiplier:Get()
end

function u15.GetRemainingSecondsFromExpiry(a1, a2) -- Line: 28
    -- upvalues: Workspace (val)
    if typeof(a1) ~= "number" then
        return 0
    end
    return (math.max(0, a1 - (a2 or Workspace:GetServerTimeNow())))
end

function u15.GetRemainingSeconds(a1, a2) -- Line: 36 -- upvalues: u15 (ref) -- types: a1: userdata?, a2: number?
    if a1 == nil then
        return 0
    end
    return u15.GetRemainingSecondsFromExpiry(a1:GetAttribute("EarningsBoostExpiresAt"), a2)
end

function u15.GetBonus(a1, a2) -- Line: 48 -- upvalues: u15 (ref) -- types: a1: userdata?, a2: number?
    if a1 == nil then
        return 1, 0
    end
    local Attribute = a1:GetAttribute("EarningsBonusMultiplier")
    local v1 = u15.GetRemainingSecondsFromExpiry(a1:GetAttribute("EarningsBonusExpiresAt"), a2)
    if type(Attribute) == "number" and not (v1 <= 0) then
        return Attribute, v1
    end
    return 1, 0
end

function u15.GetActive(a1, a2) -- Line: 61 -- upvalues: u15 (ref) -- types: a1: userdata?, a2: number?
    local v1 = u15.GetRemainingSeconds(a1, a2)
    local v2 = if not (v1 > 0) then 1 else u15.GetConfiguredMultiplier()
    local v3, v4 = u15.GetBonus(a1, a2)
    if v2 < v3 then
        return v3, v4
    end
    return v2, v1
end

function u15.GetMultiplier(a1) -- Line: 71 -- upvalues: u15 (ref) -- types: a1: userdata?
    return (u15.GetActive(a1))
end

function u15.GetChangedSignal(a1) -- Line: 75 -- types: a1: userdata
    return a1:GetAttributeChangedSignal("EarningsBoostExpiresAt")
end

u15 = ((require((game:GetService("ReplicatedStorage")).Shared.Flags.BalanceConfig)).Bind(
    "Game.Balance.PlayerEarningsBoost",
    u15,
    {MULTIPLIER = true, DURATION_SECONDS = true},
    false
))
return u15