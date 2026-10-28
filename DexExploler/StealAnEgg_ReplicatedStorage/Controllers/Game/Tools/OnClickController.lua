-- Script path: ReplicatedStorage.Controllers.Game.Tools.OnClickController
-- Decompile time: 2.09 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local t = require(ReplicatedStorage.Packages.t)
require(ReplicatedStorage.Shared.Globals.Constants)
local Gears = require(ReplicatedStorage.Data.Gears)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local ToolGameplayGuard = require(ReplicatedStorage.Client.ToolGameplayGuard)
local u36 = {[Enum.UserInputType.MouseButton1] = true, [Enum.UserInputType.Touch] = true}
local u41 = {[Enum.KeyCode.ButtonR2] = true}
local LocalPlayer = Players.LocalPlayer
return {
    Start = function() -- Line: 30
        -- upvalues: t (val), Gears (val), u36 (val), u41 (val), LocalPlayer (val), ToolGameplayGuard (val)
        -- upvalues: Remotes (val), UserInputService (val)
        local function isBatTool(a1) -- Line: 35 -- upvalues: t (upval), Gears (upval) -- types: a1: userdata
            local Attribute = a1:GetAttribute("GearName")
            t.strict(t.optional(t.string))(Attribute)
            if Attribute == nil then
                return false
            end
            return Gears.GearNameExists(Attribute) and Gears.Directory[Attribute].BatControllerData ~= nil
        end

        local function isActivationInput(a1) -- Line: 46 -- upvalues: u36 (upval), u41 (upval) -- types: a1: userdata
            local v1 = true
            if u36[a1.UserInputType] ~= true then
                v1 = u41[a1.KeyCode] == true
            end
            return v1
        end

        local function trySendActivation() -- Line: 51
            -- upvalues: LocalPlayer (upval), ToolGameplayGuard (upval), isBatTool (val), Remotes (upval)
            local v1 = LocalPlayer
            if not v1 then
                return
            end
            local Character = v1.Character
            if not Character then
                return
            end
            v1 = Character:FindFirstChildWhichIsA("Tool")
            if not v1 then
                return
            end
            if ToolGameplayGuard.AllowsLocalUse(v1) and v1:GetAttribute("BanjoBridgePlaying") ~= true then
                if isBatTool(v1) then
                    return
                end
                Remotes.ToolTrigger.Trigger:FireServer(v1)
                return
            end
        end

        UserInputService.InputBegan:Connect(function(a1) -- Line: 83 -- upvalues: u36 (upval), u41 (upval), trySendActivation (val) -- types: a1: userdata
            local v1 = true
            if u36[a1.UserInputType] ~= true then
                v1 = u41[a1.KeyCode] == true
            end
            if not v1 then
                return
            end
            trySendActivation()
        end)
    end,
}