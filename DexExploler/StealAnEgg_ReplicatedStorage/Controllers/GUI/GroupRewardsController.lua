-- Script path: ReplicatedStorage.Controllers.GUI.GroupRewardsController
-- Decompile time: 5.57 ms

local GroupService = game:GetService("GroupService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local t = require(ReplicatedStorage.Packages.t)
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local Confetti = require(ReplicatedStorage.Client.UI.VFX.Confetti)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local GUI = require(ReplicatedStorage.Client.GUI)
local TryLock = require(ReplicatedStorage.Shared.Utils.TryLock)
local Log = require(ReplicatedStorage.Packages.Log)
local Message = require(ReplicatedStorage.Client.Message)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local SpeedPower = require(ReplicatedStorage.Client.RewardFeedback.SpeedPower)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local u87 = ColorSequence.new(Color3.fromRGB(150, 150, 150), Color3.fromRGB(110, 110, 110))
return {
    Start = function() -- Line: 33
        -- upvalues: Log (val), Players (val), GUI (val), Workspace (val), TryLock (val), t (val), u87 (val), Save (val)
        -- upvalues: Remotes (val), Message (val), Tabs (val), Confetti (val), SpeedPower (val), Constants (val)
        -- upvalues: GroupService (val), ButtonFX (val)
        local v1 = Log.new()
        local LocalPlayer = Players.LocalPlayer
        local BuyCash = GUI.GroupReward().Frame.BuyCash
        local Price = BuyCash:FindFirstChild("Price")
        local UIGradient = BuyCash:FindFirstChildOfClass("UIGradient")
        local ProximityPrompt = Workspace.World.GroupReward.ProximityPrompt
        local Text = Price.Text
        local Color = if UIGradient == nil then nil else UIGradient.Color
        local u26 = TryLock()
        assert(ProximityPrompt:IsA("ProximityPrompt"), "Expected GroupReward.ProximityPrompt to be a ProximityPrompt")
        local v2 = false
        if Price ~= nil then
            v2 = Price:IsA("TextLabel")
        end
        assert(v2, "FreeGift.Frame.BuyCash.Price must be a TextLabel")

        local function renderClaimState(a1) -- Line: 60
            -- upvalues: t (upval), Price (val), Text (val), UIGradient (val), Color (val), u87 (upval)
            t.strict(t.boolean)(a1)
            Price.Text = if not a1 then Text else "CLAIMED!"
            if UIGradient ~= nil and Color ~= nil then
                UIGradient.Color = if not a1 then Color else u87
            end
        end

        local function updateView() -- Line: 68
            -- upvalues: Save (upval), t (upval), Price (val), Text (val), UIGradient (val), Color (val), u87 (upval)
            local v1 = Save.Await()
            if v1 == nil then
                return
            end
            local v2 = v1.ClaimedGroupReward == true
            t.strict(t.boolean)(v2)
            Price.Text = if not v2 then Text else "CLAIMED!"
            if UIGradient ~= nil and Color ~= nil then
                UIGradient.Color = if not v2 then Color else u87
            end
        end

        local function invokeClaim(a1) -- Line: 77
            -- upvalues: t (upval), Remotes (upval), Message (upval), Tabs (upval), Price (val), UIGradient (val)
            -- upvalues: Color (val), u87 (upval), Confetti (upval), SpeedPower (upval)
            t.strict(t.boolean)(a1)
            local v1, v2, v3 = Remotes.GroupPerk.RedeemPerk:InvokeServer(a1)
            if not v1 then
                Message.Notice(v2 or "Failed to claim reward!")
                return false
            end
            t.strict(t.number)(v3)
            if Tabs.IsActive("GroupReward") then
                Tabs.Deactivate()
            end
            t.strict(t.boolean)(true)
            Price.Text = "CLAIMED!"
            if UIGradient ~= nil and Color ~= nil then
                UIGradient.Color = u87
            end
            Message.Notice("REWARD CLAIMED!")
            Confetti.Burst()
            SpeedPower.Announce(v3)
            return true
        end

        local function resolveClientMembership() -- Line: 98
            -- upvalues: LocalPlayer (val), Constants (upval), Message (upval), GroupService (upval)
            local success, err = pcall(function() -- Line: 100 -- upvalues: LocalPlayer (upval), Constants (upval)
                return LocalPlayer:IsInGroupAsync(Constants.GROUP_ID)
            end)
            if not success then
                Message.Notice("Failed to verify your group membership!")
                return false, false
            end
            if err then
                return true, true
            end
            local success_2, err_2 = pcall(function() -- Line: 112 -- upvalues: GroupService (upval), Constants (upval)
                return GroupService:PromptJoinAsync(Constants.GROUP_ID)
            end)
            if not success_2 then
                Message.Notice("Failed to open the group join prompt!")
                return false, false
            end
            if err_2 ~= Enum.GroupMembershipStatus.Joined and err_2 ~= Enum.GroupMembershipStatus.AlreadyMember then
                if err_2 ~= Enum.GroupMembershipStatus.JoinRequestPending then
                    Message.Notice("You must join the group to claim this reward!")
                else
                    Message.Notice("Your request to join the group is pending approval.")
                end
                return false, false
            end
            return true, true
        end

        local function onClaimActivated() -- Line: 135
            -- upvalues: Save (upval), Message (upval), resolveClientMembership (val), invokeClaim (val)
            local v1 = Save.Await()
            if v1 == nil then
                Message.WarnGeneric()
                return
            end
            if v1.ClaimedGroupReward == true then
                Message.Notice("You already claimed this reward!")
                return
            end
            local v2, v3 = resolveClientMembership()
            if not v2 then
                return
            end
            invokeClaim(v3)
        end

        ButtonFX(BuyCash, 1.08, function() -- Line: 159 -- upvalues: u26 (val), onClaimActivated (val)
            u26(onClaimActivated)
        end)
        ProximityPrompt.Triggered:Connect(function() -- Line: 161 -- upvalues: Tabs (upval)
            Tabs.Toggle("GroupReward")
        end)
        if not Save.IsLoaded() then
            Save.Loaded:Connect(updateView)
        else
            local v3 = Save.Await()
            if v3 ~= nil then
                local v4 = v3.ClaimedGroupReward == true
                t.strict(t.boolean)(v4)
                Price.Text = if not v4 then Text else "CLAIMED!"
                if UIGradient ~= nil and Color ~= nil then
                    UIGradient.Color = if not v4 then Color else u87
                end
            end
        end
        Save.WatchFields({"ClaimedGroupReward"}, updateView)
        v1:AtInfo():Log("Group rewards client initialized")
    end,
}