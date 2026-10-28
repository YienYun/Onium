-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.LightVsDarkness.MusicSystem
-- Decompile time: 3.91 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local MusicDirector = require(ReplicatedStorage.Client.MusicDirector)
local Preferences = require(ReplicatedStorage.Shared.Preferences)
require(ReplicatedStorage.Packages.Trove)
local Quad = Enum.EasingStyle.Quad
local InOut = Enum.EasingDirection.InOut
local u33 = nil
local u34 = {}
local u35 = false

local function resolveTrack(a1) -- Line: 47 -- upvalues: SoundService (val) -- types: a1: string
    local v1 = script:FindFirstChild(a1)
    local v2 = ("LightVsDarkness.%* must be a Sound"):format(a1)
    assert(v1 and v1:IsA("Sound"), v2)
    local AdminAbuseMusic = SoundService.Music:FindFirstChild("AdminAbuseMusic")
    assert(AdminAbuseMusic and AdminAbuseMusic:IsA("SoundGroup"), "SoundService.Music.AdminAbuseMusic must be a SoundGroup")
    v1.SoundGroup = AdminAbuseMusic
    v1.Looped = true
    return {Sound = v1, Volume = v1.Volume}
end

local MusicNormal = resolveTrack("MusicNormal")
local MusicIntense = resolveTrack("MusicIntense")

local function fade(a1, a2) -- Line: 62
    -- upvalues: u34 (val), Audio (val), Quad (val), InOut (val)
    local Sound = a1.Sound
    local v1 = u34[Sound]
    if v1 then
        v1:Cancel()
    end
    if a2 > 0 and not Sound.IsPlaying then
        Sound.Volume = 0
        Sound:Play()
    end
    local u24 = Audio.FadeTo(Sound, {Seconds = 1.5, Volume = a2, Style = Quad, Direction = InOut})
    u34[Sound] = u24
    u24.Completed:Once(function(a1) -- Line: 74 -- upvalues: u34 (upval), Sound (val), u24 (val), a2 (val)
        if u34[Sound] ~= u24 then
            return
        end
        u34[Sound] = nil
        if a1 == Enum.PlaybackState.Completed and a2 <= 0 then
            Sound:Stop()
        end
    end)
end

local function isFinalClash() -- Line: 85 -- upvalues: Workspace (val)
    return Workspace:GetAttribute("LvdFinalClash") == true
end

local function refresh() -- Line: 91
    -- upvalues: u35 (ref), Preferences (val), Workspace (val), fade (val), MusicNormal (val), MusicIntense (val)
    local Music = u35 and Preferences.IsOn("Music")
    local v1 = Workspace:GetAttribute("LvdFinalClash") == true
    fade(MusicNormal, if not Music then 0 else if v1 then 0 else MusicNormal.Volume)
    fade(MusicIntense, if not Music then 0 else if not v1 then 0 else MusicIntense.Volume)
end

local function stop() -- Line: 98
    -- upvalues: u35 (ref), Preferences (val), Workspace (val), fade (val), MusicNormal (val), MusicIntense (val)
    if not u35 then
        return
    end
    u35 = false
    local Music = u35 and Preferences.IsOn("Music")
    local v1 = Workspace:GetAttribute("LvdFinalClash") == true
    fade(MusicNormal, if not Music then 0 else if v1 then 0 else MusicNormal.Volume)
    fade(MusicIntense, if not Music then 0 else if not v1 then 0 else MusicIntense.Volume)
end

local function start() -- Line: 107
    -- upvalues: u33 (ref), u35 (ref), MusicDirector (val), Workspace (val), refresh (val), Preferences (val)
    -- upvalues: fade (val), MusicNormal (val), MusicIntense (val), stop (val)
    local AssetTrove = u33.AssetTrove
    u35 = true
    MusicDirector.SetEventMusic(true)
    AssetTrove:Add(function() -- Line: 111 -- upvalues: MusicDirector (upval)
        MusicDirector.SetEventMusic(false)
    end)
    AssetTrove:Connect(Workspace:GetAttributeChangedSignal("LvdFinalClash"), refresh)
    AssetTrove:Add((Preferences.Observe("Music", function() -- Line: 115
        -- upvalues: u35 (upval), Preferences (upval), Workspace (upval), fade (upval), MusicNormal (upval)
        -- upvalues: MusicIntense (upval)
        local Music = u35 and Preferences.IsOn("Music")
        local v1 = Workspace:GetAttribute("LvdFinalClash") == true
        local v2 = fade
        local Volume = if not Music then 0 else if v1 then 0 else MusicNormal.Volume
        v2(MusicNormal, Volume)
        v2 = fade
        local Volume_2 = if not Music then 0 else if not v1 then 0 else MusicIntense.Volume
        v2(MusicIntense, Volume_2)
    end)))
    AssetTrove:Add(stop)
end

return function(a1) -- Line: 123 -- upvalues: u33 (ref), start (val), stop (val) -- types: a1: table
    u33 = a1
    return {Start = start, Stop = stop}
end