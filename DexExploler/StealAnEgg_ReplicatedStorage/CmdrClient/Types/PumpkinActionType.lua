-- Script path: ReplicatedStorage.CmdrClient.Types.PumpkinActionType
-- Decompile time: 0.33 ms

local u0 = {"start", "quick", "join", "king", "cannon", "stun", "defeat", "timeup", "stop", "status"}
return function(a1) -- Line: 14 -- upvalues: u0 (val)
    a1:RegisterType("pumpkinAction", (a1.Cmdr.Util.MakeEnumType("PumpkinAction", u0)))
end