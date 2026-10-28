-- Script path: ReplicatedStorage.Controllers.Game.FuseMachineController
-- Decompile time: 3.56 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Directory = require(ReplicatedStorage.Data.Assets).Directory
local Audio = require(ReplicatedStorage.Shared.Audio)
require(ReplicatedStorage.Shared.Globals.Constants)
local FuseMachineMotion = require(ReplicatedStorage.Client.FuseMachineMotion)
local FuseMachineSignals = require(ReplicatedStorage.Client.FuseMachineSignals)
local FuseMachine = require(ReplicatedStorage.Shared.Types.FuseMachine)
local Log = require(ReplicatedStorage.Packages.Log)
local Message = require(ReplicatedStorage.Client.Message)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local u60 = Log.new()
return {
    Start = function() -- Line: 31
        -- upvalues: Workspace (val), Toast (val), Directory (val), u60 (val), FuseMachineMotion (val), Audio (val)
        -- upvalues: Message (val), Remotes (val), Tabs (val), FuseMachineSignals (val), FuseMachine (val)
        local Machines = Workspace:WaitForChild("World").Machines
        assert(Machines:IsA("Folder"), "Workspace.World.Machines must be a Folder")
        local FuseMachine_2 = Machines.FuseMachine
        assert(FuseMachine_2:IsA("Model"), "Workspace FuseMachine must be a Model")
        local Machine = FuseMachine_2.Machine
        assert(Machine:IsA("BasePart"), "FuseMachine.Machine must be a BasePart")
        local Attachment = Machine.Attachment
        assert(Attachment:IsA("Attachment"), "FuseMachine.Machine.Attachment must be an Attachment")
        local ProximityPrompt = Attachment.ProximityPrompt
        assert(ProximityPrompt:IsA("ProximityPrompt"), "FuseMachine proximity prompt must be a ProximityPrompt")
        local u45 = 0

        local function notifyError(a1) -- Line: 49 -- upvalues: Toast (upval) -- types: a1: string
            Toast.Show({Seconds = 3, Text = a1, Color = Color3.fromRGB(255, 0, 0)})
        end

        local function playFuseAndGrant(a1) -- Line: 57
            -- upvalues: Directory (upval), u60 (upval), u45 (ref), ProximityPrompt (val), FuseMachineMotion (upval)
            -- upvalues: FuseMachine_2 (val), Machine (val), Audio (upval), Message (upval), Remotes (upval)
            -- upvalues: Toast (upval), Tabs (upval)
            local v1
            local AssetCategory = a1.AssetCategory
            local v2 = Directory[AssetCategory]
            if v2 == nil then
                (u60:AtError()):Log("Fuse result category has no asset config", {Category = AssetCategory})
                return
            end
            local Egg = v2.Egg
            u45 = u45 + 1
            local u16 = u45
            ProximityPrompt.Enabled = false
            if not FuseMachineMotion.Run(FuseMachine_2, Machine, function() -- Line: 72 -- upvalues: u45 (upval), u16 (val)
                local v0
                if u45 == u16 then
                    v0 = true
                else
                    v0 = false
                end
                return v0
            end) then
                ProximityPrompt.Enabled = true
                return
            end
            Audio.Play(103131639134026, script)
            local Notice = Message.Notice
            local v3 = ("You fused <font color=\"#%*\">%*</font>"):format(v2.Rarity.Color:ToHex(), Egg.DisplayName)
            local v4 = {LeaveClosed = true, Image = Egg.Icon}
            Notice(v3, v4)
            v1, v3 = Remotes.Fusery.FinishReveal:InvokeServer()
            if not v1 then
                v4 = if typeof(v3) ~= "string" then "Failed to grant fused egg" else v3
                Toast.Show({Seconds = 3, Text = v4, Color = Color3.fromRGB(255, 0, 0)})
            end
            ProximityPrompt.Enabled = true
            Tabs.Deactivate({instant = true})
        end

        ProximityPrompt.ActionText = "Fuse Pets"
        ProximityPrompt.Triggered:Connect(function() -- Line: 103 -- upvalues: Tabs (upval)
            Tabs.Activate("PetFuse")
        end)
        FuseMachineSignals.FuseStarted:Connect(function(a1) -- Line: 105 -- upvalues: FuseMachine (upval), playFuseAndGrant (val)
            assert(FuseMachine.FuseResult(a1), "Fuse started signal requires a valid serialized reward egg")
            task.spawn(playFuseAndGrant, a1)
        end)
    end,
}