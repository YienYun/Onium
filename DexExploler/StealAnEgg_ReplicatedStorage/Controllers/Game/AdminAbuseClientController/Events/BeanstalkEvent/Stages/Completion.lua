-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.BeanstalkEvent.Stages.Completion
-- Decompile time: 1.18 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BeanstalkEvent = require(ReplicatedStorage.Data.BeanstalkEvent)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
require(ReplicatedStorage.Packages.Trove)
local UISystem = require(script.Parent.Parent.UISystem)
local LocalPlayer = Players.LocalPlayer

local function hasClaimed() -- Line: 24 -- upvalues: LocalPlayer (val), BeanstalkEvent (val)
    return LocalPlayer:GetAttribute(BeanstalkEvent.ClaimedAttribute) == true
end

return {
    Run = function(a1, a2, a3, a4) -- Line: 32
        -- upvalues: UISystem (val), LocalPlayer (val), BeanstalkEvent (val), Remotes (val)
        UISystem.SetTask("EVENT COMPLETE")
        if not a4 then
            require(script.Parent.Parent.Cutscenes.EndingCutscene)(a1).Run()
        end
        while true do
            if LocalPlayer:GetAttribute(BeanstalkEvent.ClaimedAttribute) == true then
                break
            end
            Remotes.BeanstalkEvent.AskClaimReward:FireServer(not v1)
            task.wait(1)
        end
        UISystem.Finish()
    end,
}