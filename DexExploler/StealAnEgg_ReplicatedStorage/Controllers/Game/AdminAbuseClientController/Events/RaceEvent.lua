-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.RaceEvent
-- Decompile time: 1.74 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
game:GetService("ContentProvider")
game:GetService("RunService")
game:GetService("Players")
local MountRace = require(ReplicatedStorage.Data.MountRace)
require(ReplicatedStorage.Shared.Utils.Preload)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u44 = Trove.new()
local u46 = Trove.new()

local function playOutro() -- Line: 27 -- upvalues: u46 (val), Remotes (val)
    local v1 = u46:Extend()
    xpcall((require(script.Cutscenes.OutroCutscene)(v1)).Run, warn)
    v1:Clean()
    Remotes.MountRace.OutroFinished:FireServer()
end

return {
    StartEvent = function(a1, a2, a3) -- Line: 38
        -- upvalues: u44 (val), u46 (val), Workspace (val), MountRace (val), playOutro (val)
        u44:Clean()
        u46:Clean()
        u46:Connect(Workspace:GetAttributeChangedSignal(MountRace.OutroAttribute), function() -- Line: 42 -- upvalues: Workspace (upval), MountRace (upval), playOutro (upval)
            if Workspace:GetAttribute(MountRace.OutroAttribute) == true then
                task.spawn(playOutro)
            end
        end)
        local v1 = a3 or {}
        if not v1.SkipCutscenes and not v1.WasInProgress then
            local success = xpcall((require(script.Cutscenes.IntroCutscene)(u44)).Run, warn)
            if not success then
                u44:Clean()
            end
            return
        end
    end,
    StopEvent = function(a1) -- Line: 59 -- upvalues: u44 (val), u46 (val)
        u44:Clean()
        u46:Clean()
    end,
}