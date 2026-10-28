-- Script path: ReplicatedStorage.CmdrClient.Types.MinigameType
-- Decompile time: 0.41 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Minigames = require(ReplicatedStorage.Shared.Modules.Minigames)
return function(a1) -- Line: 5 -- upvalues: Minigames (val)
    a1:RegisterType("minigameName", (a1.Cmdr.Util.MakeEnumType("Minigame", Minigames.Names)))
end