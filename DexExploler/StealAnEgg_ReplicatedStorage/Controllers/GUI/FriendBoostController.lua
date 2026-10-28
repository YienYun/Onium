-- Script path: ReplicatedStorage.Controllers.GUI.FriendBoostController
-- Decompile time: 2.47 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Confetti = require(ReplicatedStorage.Client.UI.VFX.Confetti)
local GameFlags = require(ReplicatedStorage.Shared.Flags.GameFlags)
local Hud = require(ReplicatedStorage.Client.Hud)
local FriendRoster = require(ReplicatedStorage.Shared.Modules.FriendRoster)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local FriendsInServerAttribute = FriendRoster.FriendsInServerAttribute
local LocalPlayer = Players.LocalPlayer
return {
    Start = function() -- Line: 22
        -- upvalues: Hud (val), LocalPlayer (val), FriendsInServerAttribute (val), GameFlags (val), Players (val)
        -- upvalues: Remotes (val), Confetti (val)
        local FriendBoost = Hud.Find("FriendBoost")
        local CurrentBoost = if FriendBoost == nil then nil else FriendBoost:FindFirstChild("CurrentBoost")
        if FriendBoost ~= nil then
            FriendBoost.Visible = false
        end

        local function setBoostVisible(a1) -- Line: 33 -- upvalues: FriendBoost (val) -- types: a1: boolean
            if FriendBoost ~= nil then
                FriendBoost.Visible = a1
            end
        end

        local function onFriendsInGame() -- Line: 39 -- upvalues: FriendBoost (val)
            if FriendBoost ~= nil then
                FriendBoost.Visible = true
            end
        end

        local function onNoFriends() -- Line: 41 -- upvalues: FriendBoost (val)
            if FriendBoost ~= nil then
                FriendBoost.Visible = false
            end
        end

        local function updateBoostsDisplay() -- Line: 43
            -- upvalues: LocalPlayer (upval), FriendsInServerAttribute (upval), FriendBoost (val), GameFlags (upval)
            -- upvalues: CurrentBoost (val)
            local Attribute = LocalPlayer:GetAttribute(FriendsInServerAttribute)
            if typeof(Attribute) == "number" and not (Attribute <= 0) then
                local v1 = math.floor((GameFlags.FriendBoostPercentPerFriend:Get()) * (math.clamp(Attribute, 0, (GameFlags.FriendBoostCap:Get()))))
                if v1 <= 0 then
                    if FriendBoost ~= nil then
                        FriendBoost.Visible = false
                    end
                    return
                end
                if FriendBoost ~= nil then
                    FriendBoost.Visible = true
                end
                if CurrentBoost ~= nil then
                    local v2 = string.format("Friend Boost: +%d%%", v1)
                    CurrentBoost.Text = v2
                    local Shadow = CurrentBoost:FindFirstChild("Shadow")
                    if Shadow ~= nil then
                        Shadow.Text = v2
                    end
                end
                return
            end
            if FriendBoost ~= nil then
                FriendBoost.Visible = false
            end
        end

        ;(LocalPlayer:GetAttributeChangedSignal(FriendsInServerAttribute)):Connect(updateBoostsDisplay)
        updateBoostsDisplay()
        Players.PlayerAdded:Connect(updateBoostsDisplay)
        Players.PlayerRemoving:Connect(updateBoostsDisplay)
        GameFlags.FriendBoostPercentPerFriend.Changed:Connect(updateBoostsDisplay)
        GameFlags.FriendBoostCap.Changed:Connect(updateBoostsDisplay)
        Remotes.Referrals.InviteLanded.OnClientEvent:Connect(function() -- Line: 78 -- upvalues: Confetti (upval)
            Confetti.Burst()
        end)
        return {}
    end,
}