-- Script path: ReplicatedStorage.CmdrClient.Types.AdminEventType
-- Decompile time: 1.46 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("ServerScriptService")
local Minigames = require(ReplicatedStorage.Shared.Modules.Minigames)
local u15 = {
    "RecoveryEvent",
    "DemonicEvent",
    "Countdown",
    "DragonEggEvent",
    "CaptureTheEgg",
    "GreatBloom",
    "AdminAbuse",
    "MonsterEvent",
    "RiftEvent",
    "RiftOpen",
    "LightVsDarkness",
    "SammyEvent",
    "ScrambleBoss",
    "BeanstalkEvent",
    "ButterflyBloom",
    "TrainEvent",
    "RedLightGreenLight",
    "TrexRun",
    "RaceEvent",
    "RaceRally",
    "CursedIslandWars",
    "PumpkinBoss",
}
local u38 = {}
for i, j in u15 do
    if not Minigames.IsMinigame(j) then
        table.insert(u38, j)
    end
end
return function(a1) -- Line: 38 -- upvalues: u15 (val), u38 (val)
    a1:RegisterType("adminEventType", (a1.Cmdr.Util.MakeEnumType("AdminEventType", u15)))
    a1:RegisterType("adminStartEventType", (a1.Cmdr.Util.MakeEnumType("AdminStartEventType", u38)))
end