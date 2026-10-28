-- Script path: ReplicatedStorage.Shared.Util.ScrambleLeaveTimer
-- Decompile time: 0.96 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local ScrambleTradeInFlags = require(ReplicatedStorage.Shared.Flags.ScrambleTradeInFlags)
return table.freeze({
    IsExpired = function() -- Line: 10 -- upvalues: ScrambleTradeInFlags (val), Workspace (val)
        local v1 = ScrambleTradeInFlags.LeavesAtUnix:Get()
        local v2 = false
        if v1 > 0 then
            v2 = v1 <= Workspace:GetServerTimeNow()
        end
        return v2
    end,
    SecondsLeft = function() -- Line: 15 -- upvalues: ScrambleTradeInFlags (val), Workspace (val)
        local v1 = ScrambleTradeInFlags.LeavesAtUnix:Get()
        if v1 <= 0 then
            return 0
        end
        return (math.max(math.ceil(v1 - (Workspace:GetServerTimeNow())), 0))
    end,
    Text = function(a1) -- Line: 23 -- types: a1: number
        return string.format("Leaves in %02d:%02d:%02d", a1 // 3600, a1 % 3600 // 60, a1 % 60)
    end,
})