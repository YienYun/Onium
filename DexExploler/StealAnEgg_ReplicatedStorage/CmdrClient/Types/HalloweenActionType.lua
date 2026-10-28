-- Script path: ReplicatedStorage.CmdrClient.Types.HalloweenActionType
-- Decompile time: 0.32 ms

local u0 = {
    "status",
    "enable",
    "disable",
    "reset",
    "enter",
    "leave",
    "batch",
    "monsters",
    "event",
    "tokens",
    "buy",
    "progress",
    "resetprogress",
    "tutorial",
}
return function(a1) -- Line: 20 -- upvalues: u0 (val)
    a1:RegisterType("halloweenAction", (a1.Cmdr.Util.MakeEnumType("HalloweenAction", u0)))
end