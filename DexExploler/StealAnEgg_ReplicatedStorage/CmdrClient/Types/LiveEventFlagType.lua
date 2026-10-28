-- Script path: ReplicatedStorage.CmdrClient.Types.LiveEventFlagType
-- Decompile time: 0.59 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LiveEventFlags = require(ReplicatedStorage.Shared.Flags.LiveEventFlags)
local u10 = {"set", "schedule", "reset", "status"}
return function(a1) -- Line: 11 -- upvalues: LiveEventFlags (val), u10 (val)
    a1:RegisterType("liveEventFlagName", (a1.Cmdr.Util.MakeEnumType("LiveEventFlagName", (table.clone(LiveEventFlags.Names)))))
    a1:RegisterType("liveEventFlagAction", (a1.Cmdr.Util.MakeEnumType("LiveEventFlagAction", u10)))
end