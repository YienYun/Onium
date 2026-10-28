-- Script path: ReplicatedStorage.Client.Modules.SakuraBloomPolicy
-- Decompile time: 0.58 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameFlags = require(ReplicatedStorage.Shared.Flags.GameFlags)
local u10 = {}

function u10.HasBloomUnlocked(a1, a2) -- Line: 14 -- upvalues: GameFlags (val) -- types: a1: boolean, a2: table?
    if not GameFlags.GreatBloomEnabled:Get() then
        return false
    end
    if a1 and a2 ~= nil then
        return a2.Sakura.Unlocked == true
    end
    return false
end

function u10.CanShowBloom(a1, a2, a3) -- Line: 21 -- upvalues: u10 (val) -- types: a1: boolean, a2: boolean, a3: table?
    return a1 and u10.HasBloomUnlocked(a2, a3)
end

return table.freeze(u10)