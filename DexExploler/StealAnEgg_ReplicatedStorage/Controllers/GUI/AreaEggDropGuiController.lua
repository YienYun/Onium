-- Script path: ReplicatedStorage.Controllers.GUI.AreaEggDropGuiController
-- Decompile time: 3.45 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AreaEggs = require(ReplicatedStorage.Shared.Types.AreaEggs)
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local EggState = require(ReplicatedStorage.Client.EggState)
local GUI = require(ReplicatedStorage.Client.GUI)
local HalloweenDimension = require(ReplicatedStorage.Shared.Util.HalloweenDimension)
local Log = require(ReplicatedStorage.Packages.Log)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Timer = require(ReplicatedStorage.Packages.Timer)
local ToolGameplayGuard = require(ReplicatedStorage.Client.ToolGameplayGuard)
local Trove = require(ReplicatedStorage.Packages.Trove)
local PlayerRequest = AreaEggs.DropReasons.PlayerRequest
local Carrying = HalloweenDimension.PlayerAttributes.Carrying
local u60 = Log.new()
local LocalPlayer = Players.LocalPlayer
return {
    Start = function() -- Line: 35
        -- upvalues: GUI (val), Trove (val), LocalPlayer (val), Carrying (val), ToolGameplayGuard (val), ButtonFX (val)
        -- upvalues: Remotes (val), u60 (val), EggState (val), PlayerRequest (val), Timer (val)
        local u2 = GUI.DropHeldEgg()
        local v1 = Trove.new()
        local u6 = false

        local function isDimensionCarrying() -- Line: 44 -- upvalues: LocalPlayer (upval), Carrying (upval)
            return LocalPlayer:GetAttribute(Carrying) == true
        end

        local function updateVisibility() -- Line: 48
            -- upvalues: u2 (val), u6 (ref), ToolGameplayGuard (upval), LocalPlayer (upval), Carrying (upval)
            u2.Enabled = u6 and ToolGameplayGuard.IsLocalInsideArena() or LocalPlayer:GetAttribute(Carrying) == true
        end

        u2.Enabled = false
        ButtonFX(u2.Button, nil, function() -- Line: 64
            -- upvalues: LocalPlayer (upval), Carrying (upval), Remotes (upval), u60 (upval), u2 (val), u6 (ref)
            -- upvalues: ToolGameplayGuard (upval), EggState (upval), PlayerRequest (upval)
            local v1
            local v2 = LocalPlayer:GetAttribute(Carrying) == true
            if v2 then
                v2, v1 = Remotes.HalloweenDimension.AskDropEgg:InvokeServer()
                if not v2 and v1 ~= nil then
                    (u60:AtDebug()):Log((("Drop dimension egg denied for %*: %*"):format(LocalPlayer.UserId, v1)))
                end
                u2.Enabled = u6 and ToolGameplayGuard.IsLocalInsideArena() or LocalPlayer:GetAttribute(Carrying) == true
                return
            end
            if ToolGameplayGuard.IsLocalInsideArena() then
                v2, v1 = EggState.DropFieldEgg(PlayerRequest)
                if not v2 and v1 ~= nil then
                    (u60:AtDebug()):Log((("Drop held area egg denied for %*: %*"):format(LocalPlayer.UserId, v1)))
                end
                return
            end
            u2.Enabled = u6 and ToolGameplayGuard.IsLocalInsideArena() or LocalPlayer:GetAttribute(Carrying) == true
        end)
        v1:Add((Timer.Simple(0.1, updateVisibility, true)))
        v1:Add((EggState.CarryChanged:Connect(function(a1) -- Line: 53
            -- upvalues: u6 (ref), u2 (val), ToolGameplayGuard (upval), LocalPlayer (upval), Carrying (upval)
            u2.Enabled = a1.IsCarrying and ToolGameplayGuard.IsLocalInsideArena() or LocalPlayer:GetAttribute(Carrying) == true
        end)))
        v1:Add(((LocalPlayer:GetAttributeChangedSignal(Carrying)):Connect(updateVisibility)))
        v1:AttachToInstance(script)
    end,
}