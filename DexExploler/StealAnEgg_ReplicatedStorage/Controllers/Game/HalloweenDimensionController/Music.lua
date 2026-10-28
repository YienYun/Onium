-- Script path: ReplicatedStorage.Controllers.Game.HalloweenDimensionController.Music
-- Decompile time: 8.45 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local HalloweenDimension = require(ReplicatedStorage.Shared.Util.HalloweenDimension)
local ManorInterior = require(ReplicatedStorage.Shared.Util.ManorInterior)
local MusicDirector = require(ReplicatedStorage.Client.MusicDirector)
local PumpkinBossState = require(ReplicatedStorage.Shared.Util.PumpkinBossState)
require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local u55 = ((ReplicatedStorage:WaitForChild("Assets")):WaitForChild("HalloweenDimension")):WaitForChild("Sounds")
local Inside = ManorInterior.Attributes.Inside
local Attributes = HalloweenDimension.Attributes
local PlayerAttributes = HalloweenDimension.PlayerAttributes
local ArenaName = PumpkinBossState.ArenaName
local Phase = PumpkinBossState.Attributes.Phase
local Phases = PumpkinBossState.Phases
local u64 = {PumpkinBossPhase1 = "rbxassetid://103655777684859", PumpkinBossPhase2 = "rbxassetid://79213406918674"}
local u67 = {
    [Phases.BruteIntro] = "PumpkinBossPhase1",
    [Phases.Brute] = "PumpkinBossPhase1",
    [Phases.BruteDown] = "PumpkinBossPhase1",
    [Phases.KingIntro] = "PumpkinBossPhase2",
    [Phases.King] = "PumpkinBossPhase2",
    [Phases.Shield] = "PumpkinBossPhase2",
    [Phases.Stunned] = "PumpkinBossPhase2",
    [Phases.Defeated] = "PumpkinBossPhase2",
}
return {
    Start = function(a1) -- Line: 61
        -- upvalues: u55 (val), u64 (val), Audio (val), LocalPlayer (val), PumpkinBossState (val), Phase (val)
        -- upvalues: u67 (val), Inside (val), PlayerAttributes (val), Workspace (val), Attributes (val)
        -- upvalues: MusicDirector (val), ArenaName (val)
        local u1 = {}
        local u2 = {}
        local u3 = {}
        local u4 = {}
        local u5 = nil
        local u6 = false

        local function track(a1_2) -- Line: 69
            -- upvalues: u1 (val), u55 (upval), u64 (upval), Audio (upval), a1 (val), u2 (val)
            local v1 = u1[a1_2]
            if v1 ~= nil then
                return v1
            end
            v1 = u55:FindFirstChild(a1_2)
            local v2 = u64[a1_2]
            local v3 = false
            if v1 ~= nil then
                v3 = v1:IsA("Sound")
            end
            local v4 = ("HalloweenDimension sound %* is missing"):format(a1_2)
            assert(v3 or v2 ~= nil, v4)
            local SoundId = if not v3 then v2 else v1.SoundId
            v2 = Audio.MusicTrack({Looped = true, Name = ("Halloween%*"):format(a1_2), Source = SoundId})
            a1:Add(v2)
            u1[a1_2] = v2
            u2[a1_2] = if not v3 then 0.35 else v1.Volume
            return v2
        end

        local function fade(a1, a2, a3, a4) -- Line: 86
            -- upvalues: track (val), u2 (val), u3 (val), u4 (val), Audio (upval)
            local u6 = track(a1)
            local v1 = if not a2 then 0 else u2[a1]
            local v2 = u3[u6]
            if v2 ~= nil then
                v2:Cancel()
            end
            if a2 and not u6.IsPlaying then
                if not u4[u6] then
                    u6.TimePosition = 0
                    u6:Play()
                else
                    u6:Resume()
                end
            end
            u4[u6] = nil
            local u43 = Audio.FadeTo(u6, {Volume = v1, Seconds = a3 or 1.5})
            u3[u6] = u43
            u43.Completed:Once(function(a1) -- Line: 104 -- upvalues: u3 (upval), u6 (val), u43 (val), a2 (val), a4 (val), u4 (upval)
                if u3[u6] ~= u43 then
                    return
                end
                u3[u6] = nil
                if a1 == Enum.PlaybackState.Completed and not a2 then
                    if a4 then
                        u6:Pause()
                        u4[u6] = true
                        return
                    end
                    u6:Stop()
                end
            end)
        end

        local u9 = nil

        local function wanted() -- Line: 122
            -- upvalues: LocalPlayer (upval), PumpkinBossState (upval), u9 (ref), Phase (upval), u67 (upval)
            -- upvalues: Inside (upval), PlayerAttributes (upval), Workspace (upval), Attributes (upval)
            if LocalPlayer:GetAttribute(PumpkinBossState.MemberAttribute) == true then
                local Attribute = if not u9 then nil else u9:GetAttribute(Phase)
                if type(Attribute) == "string" then
                    return u67[Attribute] or "DimensionMusic"
                end
                return "DimensionMusic"
            end
            local Character = LocalPlayer.Character
            if Character ~= nil and Character:GetAttribute("TrainEventInForgottenTown") == true then
                return "ForgottenTownMusic"
            end
            if LocalPlayer:GetAttribute(Inside) == true then
                return "ManorMusic"
            end
            if LocalPlayer:GetAttribute(PlayerAttributes.Inside) ~= true then
                return nil
            end
            local Attribute_2 = Workspace:GetAttribute(Attributes.WorldEvent)
            if type(Attribute_2) == "string" then
                return Attribute_2
            end
            return "DimensionMusic"
        end

        local function sync() -- Line: 141
            -- upvalues: wanted (val), MusicDirector (upval), u5 (ref), u6 (ref), fade (val)
            local v1 = wanted()
            local v2 = MusicDirector.IsSuppressed()
            if v1 == u5 and v2 == u6 then
                return
            end
            local v3 = u5
            local v4 = u6
            u5 = v1
            u6 = v2
            MusicDirector.SetHalloweenDimension(v1 ~= nil)
            if v3 ~= nil and v3 ~= v1 then
                fade(v3, false)
            end
            if v1 == nil then
                return
            end
            if v2 then
                fade(v1, false, 0.5, true)
                return
            end
            if v3 ~= v1 or v4 then
                fade(v1, true)
            end
        end

        local u14 = a1:Extend()
        local u18 = a1:Extend()

        local function bindArena(a1) -- Line: 178
            -- upvalues: u18 (val), u9 (ref), Phase (upval), sync (val)
            u18:Clean()
            u9 = a1
            if a1 ~= nil then
                u18:Connect(a1:GetAttributeChangedSignal(Phase), sync)
            end
        end

        local v1 = Workspace:FindFirstChild(ArenaName)
        u18:Clean()
        u9 = v1
        if v1 ~= nil then
            u18:Connect(v1:GetAttributeChangedSignal(Phase), sync)
        end
        a1:Connect(Workspace.ChildAdded, function(a1) -- Line: 187
            -- upvalues: ArenaName (upval), u18 (val), u9 (ref), Phase (upval), sync (val)
            if a1.Name == ArenaName then
                u18:Clean()
                u9 = a1
                if a1 ~= nil then
                    u18:Connect(a1:GetAttributeChangedSignal(Phase), sync)
                end
                sync()
            end
        end)
        a1:Connect(Workspace.ChildRemoved, function(a1) -- Line: 193
            -- upvalues: u9 (ref), Workspace (upval), ArenaName (upval), u18 (val), Phase (upval), sync (val)
            if a1 == u9 then
                local v1 = Workspace:FindFirstChild(ArenaName)
                u18:Clean()
                u9 = v1
                if v1 ~= nil then
                    u18:Connect(v1:GetAttributeChangedSignal(Phase), sync)
                end
                sync()
            end
        end)
        a1:Connect(LocalPlayer.CharacterAdded, function(a1) -- Line: 167 -- upvalues: u14 (val), sync (val) -- types: a1: userdata?
            u14:Clean()
            if a1 ~= nil then
                u14:Connect(a1:GetAttributeChangedSignal("TrainEventInForgottenTown"), sync)
            end
            sync()
        end)
        a1:Connect(LocalPlayer:GetAttributeChangedSignal(PumpkinBossState.MemberAttribute), sync)
        a1:Connect(LocalPlayer:GetAttributeChangedSignal(PlayerAttributes.Inside), sync)
        a1:Connect(LocalPlayer:GetAttributeChangedSignal(Inside), sync)
        a1:Connect(Workspace:GetAttributeChangedSignal(Attributes.WorldEvent), sync)
        a1:Connect(MusicDirector.SuppressedChanged, sync)
        a1:Add(function() -- Line: 206 -- upvalues: u3 (val), MusicDirector (upval)
            for i, j in u3 do
                j:Cancel()
            end
            MusicDirector.SetHalloweenDimension(false)
        end)
        local Character = LocalPlayer.Character
        u14:Clean()
        if Character ~= nil then
            u14:Connect(Character:GetAttributeChangedSignal("TrainEventInForgottenTown"), sync)
        end
        sync()
    end,
}