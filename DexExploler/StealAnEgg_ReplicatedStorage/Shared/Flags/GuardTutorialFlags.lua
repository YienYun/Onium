-- Script path: ReplicatedStorage.Shared.Flags.GuardTutorialFlags
-- Decompile time: 0.45 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)
local t = require(ReplicatedStorage.Packages.t)
return table.freeze({
    PauseNotificationEnabled = FastFlags.Replicated("Game.GuardTutorial.PauseNotificationEnabled", function(a1) -- Line: 11 -- upvalues: t (val)
        local v1, v2 = t.boolean(a1)
        assert(v1, v2)
        return a1
    end, false),
})