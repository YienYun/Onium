-- Script path: ReplicatedStorage.Client.MusicDirector
-- Decompile time: 10.62 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local GuardAreaGeometry = require(ReplicatedStorage.Shared.Util.GuardAreaGeometry)
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local Player = require(ReplicatedStorage.Shared.Player)
local Preferences = require(ReplicatedStorage.Shared.Preferences)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local AreaEggResetCycle = require(ReplicatedStorage.Data.AreaEggResetCycle)
local Shuffle = require(ReplicatedStorage.Shared.Utils.Numeric).Shuffle
local TreadmillVideoGate = require(ReplicatedStorage.Client.TreadmillVideoGate)
local v1 = {}
local u82 = Workspace:WaitForChild("World"):WaitForChild("Areas"):WaitForChild("SeparationLine")
local LocalPlayer = Players.LocalPlayer
local u87 = table.clone({1836009208, 1846088038, 9045766074, 1842150151})
Shuffle(u87, Random.new())
local u93 = 1
local u98 = Audio.MusicTrack({Name = "OutdoorMusic", Looped = false, Source = u87[u93]})
local u101 = Audio.MusicTrack({Name = "ArenaMusic", Source = 5026653246, Looped = true})
local u104 = Audio.MusicTrack({Name = "ChaseMusic", Source = 9044545570, Looped = true})
local u107 = Audio.MusicTrack({Name = "SafeZoneMusic", Source = 9044545570, Looped = true})
local u114 = if not AreaEggResetCycle.NightMusic then nil else Audio.MusicTrack({Name = "ResetNightMusic", Looped = true, Source = AreaEggResetCycle.NightMusic.Id})
local u118 = Audio.MusicTrack({Name = "DrScrambleMusic", Source = 116561685928578, Looped = true})
local v2 = {u98, u101, u104, u107, u118}
if u114 then
    table.insert(v2, u114)
end
local u134 = {}
local u135 = false
local u136 = false
local u137 = false
local u138 = false
local u139 = false
local u140 = false
local u141 = false
local u142 = false
local u143 = false
local u144 = false
local u152 = Workspace:GetAttribute("AdminAbuseOnTop") == true
local Music = Preferences.IsOn("Music")
local u163 = HiddenUIHandler.IsHidden()
local u164 = ""
local u165 = 0
local BindableEvent = Instance.new("BindableEvent")
local u169 = 0

local function fade(a1, a2, a3, a4) -- Line: 86
    -- upvalues: u134 (val), Audio (val)
    local v1 = u134[a1]
    if v1 then
        v1:Cancel()
    end
    if a2 > 0 then
        if not a1.IsPlaying then
            a1:Play()
        end
    elseif a4 and not a1.IsPlaying then
        a1:Play()
    end
    local u30 = Audio.FadeTo(a1, {
        Volume = a2,
        Seconds = a3,
        Style = Enum.EasingStyle.Quad,
        Direction = Enum.EasingDirection.InOut,
    })
    u134[a1] = u30
    u30.Completed:Once(function(a1_2) -- Line: 103 -- upvalues: u134 (upval), a1 (val), u30 (val), a2 (val), a4 (val)
        if u134[a1] ~= u30 then
            return
        end
        u134[a1] = nil
        if a1_2 == Enum.PlaybackState.Completed and a2 <= 0 and not a4 then
            a1:Pause()
        end
    end)
end

local function treadmillFeedActive() -- Line: 115 -- upvalues: u141 (ref), TreadmillVideoGate (val)
    return u141 and not TreadmillVideoGate.IsVideoPlayerDisabled()
end

local function mode() -- Line: 119
    -- upvalues: Music (ref), u165 (ref), u152 (ref), u144 (ref), u143 (ref), u142 (ref), u141 (ref)
    -- upvalues: TreadmillVideoGate (val), u163 (ref), u139 (ref), u136 (ref), u137 (ref), u135 (ref), u138 (ref)
    if not Music or u165 > 0 or u152 or u144 then
        return "Silent"
    end
    if u143 and not u142 and (not u141 or TreadmillVideoGate.IsVideoPlayerDisabled()) and not u163 then
        return "Scramble"
    end
    if u139 then
        return "Night"
    end
    if u141 and not TreadmillVideoGate.IsVideoPlayerDisabled() then
        return "Treadmill"
    end
    if u142 or u136 then
        return "Silent"
    end
    if u137 then
        if u135 then
            return "Chase"
        end
        return "Arena"
    end
    if u163 then
        return "Silent"
    end
    if u138 then
        return "SafeZone"
    end
    return "Outdoor"
end

local function refresh(a1) -- Line: 148
    -- upvalues: mode (val), u164 (ref), fade (val), u98 (val), u101 (val), u104 (val), u107 (val), u118 (val)
    -- upvalues: u114 (val), u140 (ref), AreaEggResetCycle (val), SoundService (val), u141 (ref)
    -- upvalues: TreadmillVideoGate (val), u152 (ref)
    local v1
    local v2 = mode()
    local v3 = u164
    u164 = v2
    local v4 = true
    if v2 ~= "Chase" then
        v4 = v3 == "Chase"
    end
    fade(
        u98,
        if v2 ~= "Outdoor" then 0 else 0.22,
        if a1 == nil then if not v4 then if v2 == "Arena" then 0.4 else if v3 ~= "Arena" then 0.8 else 0.4 else 0.1 else a1,
        true
    )
    fade(u101, if v2 ~= "Arena" then 0 else 1.5, v1)
    fade(u104, if v2 ~= "Chase" then 0 else 0.4, v1)
    fade(u107, if v2 ~= "SafeZone" then 0 else 0.5, v1)
    fade(u118, if v2 ~= "Scramble" then 0 else 0.5, v1)
    if u114 then
        fade(
            u114,
            if v2 ~= "Night" then 0 else if not u140 then 0 else AreaEggResetCycle.NightMusic.Volume,
            a1 or AreaEggResetCycle.MusicTransitionSeconds
        )
    end
    local AdminAbuseMusic = SoundService.Music:FindFirstChild("AdminAbuseMusic")
    if AdminAbuseMusic and AdminAbuseMusic:IsA("SoundGroup") then
        AdminAbuseMusic.Volume = if u141 and not TreadmillVideoGate.IsVideoPlayerDisabled() then 0 else if not u152 then 1 else 0
    end
    local AdminAbusePriorityMusic = SoundService.Music:FindFirstChild("AdminAbusePriorityMusic")
    if AdminAbusePriorityMusic and AdminAbusePriorityMusic:IsA("SoundGroup") then
        AdminAbusePriorityMusic.Volume = if not u141 or TreadmillVideoGate.IsVideoPlayerDisabled() then 1 else 0
    end
end

local function updateArena() -- Line: 183
    -- upvalues: Player (val), LocalPlayer (val), GuardAreaGeometry (val), u82 (val), u137 (ref), refresh (val)
    local v1 = Player.FindRootPart(LocalPlayer)
    local v2 = false
    if v1 ~= nil then
        v2 = GuardAreaGeometry.IsPastLine(u82, v1.Position)
    end
    if u137 ~= v2 then
        u137 = v2
        refresh()
    end
end

function v1.EnterSaveZone() -- Line: 192 -- upvalues: u138 (ref), refresh (val)
    if not u138 then
        u138 = true
        refresh()
    end
end

function v1.ExitSaveZone() -- Line: 199 -- upvalues: u138 (ref), refresh (val)
    if u138 then
        u138 = false
        refresh()
    end
end

function v1.HasCustomTreadmill() -- Line: 206 -- upvalues: u141 (ref)
    return u141
end

function v1.SetCarryingAreaEgg(a1) -- Line: 210 -- upvalues: u135 (ref), refresh (val) -- types: a1: boolean
    if u135 ~= a1 then
        u135 = a1
        refresh()
    end
end

function v1.SetGuardedGameplay(a1) -- Line: 217 -- upvalues: u136 (ref), refresh (val) -- types: a1: boolean
    if u136 ~= a1 then
        u136 = a1
        refresh()
    end
end

function v1.SetScrambleActive(a1) -- Line: 224 -- upvalues: u143 (ref), refresh (val) -- types: a1: boolean
    if u143 ~= a1 then
        u143 = a1
        refresh()
    end
end

function v1.SetEventMusic(a1) -- Line: 231 -- upvalues: u142 (ref), refresh (val) -- types: a1: boolean
    if u142 ~= a1 then
        u142 = a1
        refresh()
    end
end

function v1.IsSuppressed() -- Line: 238 -- upvalues: u165 (ref)
    return u165 > 0
end

function v1.Suppress() -- Line: 242 -- upvalues: u165 (ref), refresh (val), BindableEvent (val)
    u165 = u165 + 1
    if u165 == 1 then
        refresh(0.5)
        BindableEvent:Fire(true)
    end
    local u11 = false
    return function() -- Line: 249 -- upvalues: u11 (ref), u165 (upval), refresh (upval), BindableEvent (upval)
        if u11 then
            return
        end
        u11 = true
        u165 = u165 - 1
        if u165 == 0 then
            refresh()
            BindableEvent:Fire(false)
        end
    end
end

v1.SuppressedChanged = BindableEvent.Event

function v1.SetHalloweenDimension(a1) -- Line: 264 -- upvalues: u144 (ref), refresh (val) -- types: a1: boolean
    if u144 ~= a1 then
        u144 = a1
        refresh()
    end
end

function v1.SetResetNight(a1, a2) -- Line: 271
    -- upvalues: u139 (ref), u140 (ref), refresh (val)
    local v1 = a1 and a2 == true
    if u139 ~= a1 or u140 ~= v1 then
        u139 = a1
        u140 = v1
        refresh()
    end
end

u98.Ended:Connect(function() -- Line: 280 -- upvalues: u93 (ref), u87 (val), Shuffle (val), u98 (val)
    u93 = u93 + 1
    local v1 = u93
    if #u87 < v1 then
        Shuffle(u87, Random.new())
        u93 = 1
    end
    u98.SoundId = ("rbxassetid://%*"):format(u87[u93])
    u98:Play()
end)
Preferences.Observe("Music", function(a1) -- Line: 290 -- upvalues: Music (ref), refresh (val) -- types: a1: boolean
    if a1 == Music then
        return
    end
    Music = a1
    refresh()
end)
HiddenUIHandler.Changed:Connect(function(a1) -- Line: 298 -- upvalues: u163 (ref), refresh (val) -- types: a1: boolean
    u163 = a1
    refresh()
end)
Remotes.Treadmill.AssignedBeltShifted.OnClientEvent:Connect(function(a1) -- Line: 303 -- upvalues: u141 (ref), refresh (val) -- types: a1: string?
    u141 = a1 ~= nil
    refresh()
end)
;(Workspace:GetAttributeChangedSignal("AdminAbuseOnTop")):Connect(function() -- Line: 308 -- upvalues: u152 (ref), Workspace (val), refresh (val)
    u152 = Workspace:GetAttribute("AdminAbuseOnTop") == true
    refresh()
end)
TreadmillVideoGate.Changed:Connect(function() -- Line: 313 -- upvalues: u141 (ref), refresh (val)
    if u141 then
        refresh()
    end
end)
RunService.Heartbeat:Connect(function(a1) -- Line: 319
    -- upvalues: u169 (ref), Player (val), LocalPlayer (val), GuardAreaGeometry (val), u82 (val), u137 (ref)
    -- upvalues: refresh (val)
    u169 = u169 + a1
    if u169 >= 0.1 then
        u169 = u169 % 0.1
        local v1 = Player.FindRootPart(LocalPlayer)
        local v2 = false
        if v1 ~= nil then
            v2 = GuardAreaGeometry.IsPastLine(u82, v1.Position)
        end
        if u137 ~= v2 then
            u137 = v2
            refresh()
        end
    end
end)
u98:Play()
local v3 = Player.FindRootPart(LocalPlayer)
local v4 = false
if v3 ~= nil then
    v4 = GuardAreaGeometry.IsPastLine(u82, v3.Position)
end
if u137 ~= v4 then
    refresh()
end
refresh()
return (table.freeze(v1))