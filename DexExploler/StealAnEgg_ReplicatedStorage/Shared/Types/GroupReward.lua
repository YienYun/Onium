-- Script path: ReplicatedStorage.Shared.Types.GroupReward
-- Decompile time: 1.64 ms

local u17 = require(game:GetService("ReplicatedStorage").Shared.Flags.BalanceConfig).Bind(
    "Game.Balance.GroupReward",
    {Label = "+10K Speed", SpeedPowerAward = 10000},
    {SpeedPowerAward = true},
    false
)
local v1 = if u17.SpeedPowerAward ~= 10000 then ("+%* Speed"):format(((require((game:GetService("ReplicatedStorage")).Packages.FormatNumber.Simple)).FormatCompact(u17.SpeedPowerAward, ".#"))) else "+10K Speed"
u17.Label = v1
require(game:GetService("ReplicatedStorage").Shared.Flags.BalanceConfig).Changed:Connect(function() -- Line: 17 -- upvalues: u17 (ref)
    u17.Label = if u17.SpeedPowerAward ~= 10000 then ("+%* Speed"):format(((require((game:GetService("ReplicatedStorage")).Packages.FormatNumber.Simple)).FormatCompact(u17.SpeedPowerAward, ".#"))) else "+10K Speed"
end)
return u17