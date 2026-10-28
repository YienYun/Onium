-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.RiftEvent
-- Decompile time: 1.80 ms

game:GetService("Debris")
game:GetService("Lighting")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("ServerScriptService")
game:GetService("ServerStorage")
game:GetService("Workspace")
local BossEventFlags = require(ReplicatedStorage.Shared.Flags.BossEventFlags)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local u50 = require(ReplicatedStorage.Packages.Trove).new()
local u51 = false
local u52 = false

local function PlayCutscene1Async() -- Line: 31 -- upvalues: u50 (val)
    require(script.Cutscene1)(u50).Run()
end

local function PlayCutscene2Async() -- Line: 36 -- upvalues: Players (val), u50 (val)
    Players.LocalPlayer:SetAttribute("RiftCutscene2Seen", true)
    require(script.Cutscene2)(u50).Run()
end

local u55 = {}

function u55.StartEvent(a1, a2) -- Line: 46
    -- upvalues: BossEventFlags (val), u50 (val), u51 (ref), u52 (ref), Remotes (val), PlayCutscene2Async (val)
    if not BossEventFlags.ContentEnabled:Get() then
        return
    end
    u50:Clean()
    u51 = true
    u52 = false
    u50:Connect(Remotes.BossEvent.HealthShifted.OnClientEvent, function(a1) -- Line: 55 -- upvalues: u52 (upval), PlayCutscene2Async (upval) -- types: a1: number
        if not u52 and not (a1 > 0) then
            u52 = true
            task.wait(4)
            task.spawn(PlayCutscene2Async)
            return
        end
    end)
    require(script.Cutscene1)(u50).Run()
end

function u55.StopEvent(a1) -- Line: 67 -- upvalues: u50 (val), u51 (ref)
    u50:Clean()
    u51 = false
end

BossEventFlags.ContentEnabled.Changed:Connect(function() -- Line: 72 -- upvalues: BossEventFlags (val), u51 (ref), u55 (val)
    if not BossEventFlags.ContentEnabled:Get() and u51 then
        u55:StopEvent()
    end
end)
return u55