-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.PumpkinBoss
-- Decompile time: 1.94 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Workspace")
game:GetService("ContentProvider")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Debris = game:GetService("Debris")
require(ReplicatedStorage.Data.MountRace)
local Preload = require(ReplicatedStorage.Shared.Utils.Preload)
require(ReplicatedStorage.Shared.Remotes)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u48 = Trove.new()
Trove.new()

local function WarmAssets() -- Line: 26 -- upvalues: Preload (val), ReplicatedStorage (val)
    Preload.WarmAtWorkspace(script.Name, {ReplicatedStorage.CutsceneAssets.PumpkinBossCutsceneAssets})
end

task.spawn(function() -- Line: 32 -- upvalues: RunService (val), Players (val), Preload (val), ReplicatedStorage (val)
    local ServerTimeNow = workspace:GetServerTimeNow()
    if ServerTimeNow > 1792855200 then
        return
    end
    if not RunService:IsStudio() then
        local v1
        local v2 = Random.new(Players.LocalPlayer.UserId + 1792854000)
        if ServerTimeNow < 1792850400 then
            task.wait(1792850400 - ServerTimeNow)
        end
        task.wait(v2:NextNumber(0, if not v1 then 60 else 600))
    end
    Preload.WarmAtWorkspace(script.Name, {ReplicatedStorage.CutsceneAssets.PumpkinBossCutsceneAssets})
end)
return {
    StartEvent = function(a1, a2, a3) -- Line: 61
        -- upvalues: u48 (val), ReplicatedStorage (val), Players (val), Debris (val)
        u48:Clean()
        if not a3 or a3.SkipCutscenes then
            return
        end
        local v1 = ReplicatedStorage.CutsceneAssets.PumpkinBossCutsceneAssets.PlayVideo:Clone()
        v1.Parent = Players.LocalPlayer.PlayerGui
        v1.VideoFrame:Play()
        Debris:AddItem(v1, 30)
    end,
    StopEvent = function(a1) -- Line: 72 -- upvalues: u48 (val)
        u48:Clean()
    end,
}