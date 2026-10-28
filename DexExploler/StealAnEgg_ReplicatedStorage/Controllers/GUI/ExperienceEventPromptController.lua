-- Script path: ReplicatedStorage.Controllers.GUI.ExperienceEventPromptController
-- Decompile time: 10.83 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SocialService = game:GetService("SocialService")
local Workspace = game:GetService("Workspace")
require(ReplicatedStorage.Shared.Globals.Constants)
local EggState = require(ReplicatedStorage.Client.EggState)
local ExpandedLobby = require(ReplicatedStorage.Data.ExpandedLobby)
local ExperienceEventPromptPolicy = require(ReplicatedStorage.Shared.Modules.ExperienceEventPromptPolicy)
local GuardAreaGeometry = require(ReplicatedStorage.Shared.Util.GuardAreaGeometry)
local HalloweenDimension = require(ReplicatedStorage.Shared.Util.HalloweenDimension)
local Player = require(ReplicatedStorage.Shared.Player)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Timer = require(ReplicatedStorage.Packages.Timer)
local ToolGameplayGuard = require(ReplicatedStorage.Client.ToolGameplayGuard)
local Trove = require(ReplicatedStorage.Packages.Trove)
local PlayerAttributes = HalloweenDimension.PlayerAttributes
local u69 = {
    "InBossArena",
    "InScrambleArena",
    "InPumpkinArena",
    "TrainEventPhase",
    PlayerAttributes.Carrying,
    PlayerAttributes.PumpkinCarrying,
}
local LocalPlayer = Players.LocalPlayer
local u79 = Trove.new()
local u80 = {}
local u81 = nil
local u82 = nil
local u83 = nil
local u84 = nil
local u85 = false
local u86 = false
local u87 = false
local u88 = 0
local u89 = false
return {
    Start = function() -- Line: 48
        -- upvalues: Workspace (val), ExpandedLobby (val), u89 (ref), u69 (val), LocalPlayer (val)
        -- upvalues: HalloweenDimension (val), GuardAreaGeometry (val), Player (val), PlayerAttributes (val)
        -- upvalues: ToolGameplayGuard (val), ExperienceEventPromptPolicy (val), SocialService (val), u80 (val)
        -- upvalues: Remotes (val), u79 (val), Timer (val), u81 (ref), u82 (ref), u88 (ref), u83 (ref), u84 (ref)
        -- upvalues: u87 (ref), u85 (ref), u86 (ref), EggState (val)
        local function IsExpandedLobbyServer() -- Line: 49 -- upvalues: Workspace (upval), ExpandedLobby (upval)
            return (Workspace:GetAttribute(ExpandedLobby.ServerAttribute)) == ExpandedLobby.Groups.Variant
        end

        local function IsBusy() -- Line: 53 -- upvalues: u89 (upval), u69 (upval), LocalPlayer (upval)
            local Attribute
            if u89 then
                return true
            end
            for i, j in u69 do
                Attribute = LocalPlayer:GetAttribute(j)
                if Attribute ~= nil and Attribute ~= false then
                    return true
                end
            end
            local Character = LocalPlayer.Character
            local v1 = false
            if Character ~= nil then
                v1 = Character:GetAttribute("TrainEventInForgottenTown") == true
            end
            return v1
        end

        local function FindDimensionMap() -- Line: 68 -- upvalues: Workspace (upval), HalloweenDimension (upval)
            local v1 = Workspace:FindFirstChild(HalloweenDimension.MapName)
            if v1 ~= nil and v1:IsA("Model") then
                return v1
            end
            return nil
        end

        local function IsInDimensionRegion(a1, a2) -- Line: 73 -- types: a1: userdata, a2: vector
            local Attribute = a1:GetAttribute("PlayRadius")
            local v1 = if type(Attribute) ~= "number" then 700 else Attribute
            local v2 = a2 - a1:GetPivot().Position
            return Vector3.new(v2.X, 0, v2.Z).Magnitude <= v1
        end

        local function IsInDimensionSafeZone(a1, a2) -- Line: 82
            -- upvalues: GuardAreaGeometry (upval)
            local Zones = a1:FindFirstChild("Zones")
            local SafeZone = if Zones == nil then nil else Zones:FindFirstChild("SafeZone")
            local v1 = false
            if SafeZone ~= nil then
                v1 = SafeZone:IsA("BasePart") and GuardAreaGeometry.IsWithinFootprint(SafeZone, a2)
            end
            return v1
        end

        local function IsInSafeArea() -- Line: 90
            -- upvalues: Player (upval), LocalPlayer (upval), Workspace (upval), HalloweenDimension (upval)
            -- upvalues: PlayerAttributes (upval), GuardAreaGeometry (upval), ToolGameplayGuard (upval)
            -- upvalues: ExperienceEventPromptPolicy (upval), IsBusy (val)
            local v1
            local v2 = Player.FindRootPart(LocalPlayer)
            if not v2 then
                return false
            end
            local Position = v2.Position
            local v3 = Workspace:FindFirstChild(HalloweenDimension.MapName)
            v2 = if v3 == nil then nil else if not v3:IsA("Model") then nil else v3
            v3 = true
            local v4 = LocalPlayer
            if v4:GetAttribute(PlayerAttributes.Inside) ~= true then
                v3 = false
                if v2 ~= nil then
                    local Attribute = v2:GetAttribute("PlayRadius")
                    v1 = if type(Attribute) ~= "number" then 700 else Attribute
                    v4 = Position - v2:GetPivot().Position
                    v3 = Vector3.new(v4.X, 0, v4.Z).Magnitude <= v1
                end
            end
            if not v3 then
                v4 = ToolGameplayGuard.IsLocalInsideArena()
            else
                v4 = true
                if v2 ~= nil then
                    local Zones = v2:FindFirstChild("Zones")
                    local SafeZone = if Zones == nil then nil else Zones:FindFirstChild("SafeZone")
                    v1 = false
                    if SafeZone ~= nil then
                        v1 = SafeZone:IsA("BasePart") and GuardAreaGeometry.IsWithinFootprint(SafeZone, Position)
                    end
                    v4 = not v1
                end
            end
            return ExperienceEventPromptPolicy.IsSafeToPrompt(true, v4, (IsBusy()))
        end

        local function GetSoonestUnseenEvent() -- Line: 107
            -- upvalues: SocialService (upval), ExperienceEventPromptPolicy (upval), u80 (upval)
            local success, err = pcall(function() -- Line: 108 -- upvalues: SocialService (upval)
                return SocialService:GetUpcomingExperienceEventsAsync()
            end)
            if success and type(err) == "table" then
                return (ExperienceEventPromptPolicy.GetSoonestUnseenEvent(err, u80)), true
            end
            if not success then
                warn((("Failed to get upcoming experience events: %*"):format(err)))
            end
            return nil, false
        end

        local function MarkSeen(a1) -- Line: 121 -- upvalues: u80 (upval), Remotes (upval) -- types: a1: string
            u80[a1] = true
            local success, err = pcall(function() -- Line: 123 -- upvalues: Remotes (upval), a1 (val)
                return Remotes.SeasonBanner.FlagSeen:InvokeServer(a1)
            end)
            if not success then
                warn((("Failed to mark experience event prompt as seen: %*"):format(err)))
                return
            end
            if err ~= true then
                warn((("Server rejected experience event prompt acknowledgement for %*"):format(a1)))
            end
        end

        local function PromptSoonestEvent() -- Line: 133
            -- upvalues: GetSoonestUnseenEvent (val), SocialService (upval), MarkSeen (val), IsInSafeArea (val)
            local v1, v2 = GetSoonestUnseenEvent()
            if not v2 then
                return "Retry"
            end
            if not v1 then
                return "NoEvent"
            end
            local success, err = pcall(SocialService.GetEventRsvpStatusAsync, SocialService, v1.Id)
            if not success then
                warn((("Failed to get experience event RSVP status: %*"):format(err)))
                return "Retry"
            end
            if err ~= Enum.RsvpStatus.None then
                MarkSeen(v1.Id)
                return "Complete"
            end
            if not IsInSafeArea() then
                return "WaitForSafeArea"
            end
            local success_2, err_2 = pcall(SocialService.PromptRsvpToEventAsync, SocialService, v1.Id)
            if not success_2 then
                warn((("Failed to prompt for experience event RSVP: %*"):format(err_2)))
                return "Retry"
            end
            MarkSeen(v1.Id)
            return "Complete"
        end

        local u16 = u79:Add((Timer.new(0.1)))
        local u25 = u79:Add((Timer.new(ExperienceEventPromptPolicy.RetryDelaySeconds)))
        local u34 = u79:Add((Timer.new(ExperienceEventPromptPolicy.NoEventRecheckSeconds)))

        function u81() -- Line: 172 -- upvalues: u16 (val)
            if not u16:IsRunning() then
                u16:Start()
            end
        end

        function u82() -- Line: 178 -- upvalues: u88 (upval), ExperienceEventPromptPolicy (upval), u25 (val)
            u88 = u88 + 1
            local v1 = u88
            if ExperienceEventPromptPolicy.MaxAttempts <= v1 then
                local v2 = u88
                warn((("Experience event prompt stopped after %* failed attempts"):format(v2)))
                return
            end
            if not u25:IsRunning() then
                u25:Start()
            end
        end

        function u83() -- Line: 189 -- upvalues: u34 (val)
            if not u34:IsRunning() then
                u34:Start()
            end
        end

        function u84() -- Line: 195
            -- upvalues: u87 (upval), u85 (upval), Remotes (upval), u82 (upval), u86 (upval), u88 (upval), u80 (upval)
            -- upvalues: Workspace (upval), ExpandedLobby (upval), IsInSafeArea (val), u81 (upval)
            -- upvalues: PromptSoonestEvent (val), u83 (upval)
            local v1
            if u87 then
                return
            end
            u87 = true
            if u85 then
                if not u86 then
                    u87 = false
                    return
                end
                if (Workspace:GetAttribute(ExpandedLobby.ServerAttribute)) == ExpandedLobby.Groups.Variant then
                    u87 = false
                    return
                end
                if not IsInSafeArea() then
                    u87 = false
                    u81()
                    return
                end
                v1 = PromptSoonestEvent()
                u87 = false
                if v1 == "Retry" then
                    u82()
                    return
                end
                if v1 == "NoEvent" then
                    u83()
                    return
                end
                if v1 == "WaitForSafeArea" then
                    u81()
                end
                return
            end
            local success, err, v2 = pcall(function() -- Line: 202 -- upvalues: Remotes (upval)
                return Remotes.SeasonBanner.FetchState:InvokeServer()
            end)
            if success and type(err) == "boolean" and type(v2) == "table" then
                u85 = true
                u88 = 0
                for i, j in v2 do
                    if type(i) == "string" and j == true then
                        u80[i] = true
                    end
                end
                if not err then
                    u87 = false
                    return
                end
                if (Workspace:GetAttribute(ExpandedLobby.ServerAttribute)) == ExpandedLobby.Groups.Variant then
                    u87 = false
                    return
                end
                if not IsInSafeArea() then
                    u87 = false
                    u81()
                    return
                end
                v1 = PromptSoonestEvent()
                u87 = false
                if v1 == "Retry" then
                    u82()
                    return
                end
                if v1 == "NoEvent" then
                    u83()
                    return
                end
                if v1 == "WaitForSafeArea" then
                    u81()
                end
                return
            end
            if not success then
                warn((("Failed to get experience event prompt state: %*"):format(err)))
            end
            u87 = false
            u82()
        end

        u79:Connect(u16.Tick, function() -- Line: 249 -- upvalues: IsInSafeArea (val), u16 (val), u84 (upval)
            if not IsInSafeArea() then
                return
            end
            u16:Stop()
            u84()
        end)
        u79:Connect(u25.Tick, function() -- Line: 257 -- upvalues: u25 (val), u84 (upval)
            u25:Stop()
            u84()
        end)
        u79:Connect(u34.Tick, function() -- Line: 261 -- upvalues: u34 (val), u84 (upval)
            u34:Stop()
            u84()
        end)
        u79:Connect(EggState.CarryChanged, function(a1) -- Line: 265 -- upvalues: u89 (upval)
            u89 = a1.IsCarrying
        end)
        local u72 = u79:Add((Timer.new(ExperienceEventPromptPolicy.PromptDelaySeconds)))
        u79:Connect(u72.Tick, function() -- Line: 270 -- upvalues: u72 (val), u84 (upval)
            u72:Stop()
            u84()
        end)
        u89 = EggState.ReadCarryState().IsCarrying
        u79:AttachToInstance(script)
        u72:Start()
    end,
}