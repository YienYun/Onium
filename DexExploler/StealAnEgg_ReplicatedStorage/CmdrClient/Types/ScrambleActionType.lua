-- Script path: ReplicatedStorage.CmdrClient.Types.ScrambleActionType
-- Decompile time: 0.26 ms

return function(a1) -- Line: 2
    a1:RegisterType("scrambleAction", (a1.Cmdr.Util.MakeEnumType("Scramble action", {
        "status",
        "start",
        "stop",
        "drops",
        "scrap",
        "reactor",
        "augmented",
        "quest",
        "drone",
        "reset",
        "complete",
    })))
end