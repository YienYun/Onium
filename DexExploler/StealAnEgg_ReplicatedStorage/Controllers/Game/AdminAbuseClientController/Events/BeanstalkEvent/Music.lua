-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.BeanstalkEvent.Music
-- Decompile time: 5.17 ms

local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local MusicDirector = require(ReplicatedStorage.Client.MusicDirector)
local Preferences = require(ReplicatedStorage.Shared.Preferences)
require(ReplicatedStorage.Packages.Trove)
local Music = ReplicatedStorage.Assets.Sounds.BeanstalkEvent.Music
local u41 = TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local u42 = {}
local u43 = {}
local u44 = {}
local u45 = nil
local u46 = nil
local u47 = true

local function fade(a1, a2) -- Line: 38
    -- upvalues: u44 (val), TweenService (val), u41 (val)
    local v1 = u44[a1]
    if v1 then
        v1:Cancel()
    end
    if a2 > 0 and not a1.IsPlaying then
        a1.TimePosition = 0
        a1:Play()
    end
    local u23 = TweenService:Create(a1, u41, {Volume = a2})
    u44[a1] = u23
    u23.Completed:Once(function(a1_2) -- Line: 49 -- upvalues: u44 (upval), a1 (val), u23 (val), a2 (val)
        if u44[a1] == u23 then
            u44[a1] = nil
        end
        if a1_2 == Enum.PlaybackState.Completed and a2 <= 0 then
            a1:Stop()
        end
    end)
    u23:Play()
end

local function apply() -- Line: 60 -- upvalues: u47 (ref), u45 (ref), u46 (ref), u42 (val), fade (val), u43 (val)
    local v1
    if (if not u47 then nil else u45) == u46 then
        return
    end
    if v1 ~= nil and u42[v1] == nil then
        return
    end
    local v2 = u46
    u46 = v1
    if v2 ~= nil then
        fade(u42[v2], 0)
    end
    if v1 ~= nil then
        fade(u42[v1], u43[v1])
    end
end

return {
    Start = function(a1) -- Line: 80
        -- upvalues: Music (val), u43 (val), SoundService (val), u42 (val), MusicDirector (val), Preferences (val)
        -- upvalues: u47 (ref), u45 (ref), u46 (ref), fade (val), u44 (val), TweenService (val), u41 (val), Debris (val)
        local v1
        for i, j in Music:GetChildren() do
            assert(j:IsA("Sound"), (("%* must be a Sound"):format((j:GetFullName()))))
            v1 = j:Clone()
            u43[v1.Name] = v1.Volume
            v1.Volume = 0
            v1.Parent = SoundService
            u42[v1.Name] = v1
        end
        MusicDirector.SetEventMusic(true)
        a1:Add((Preferences.Observe("Music", function(a1) -- Line: 91
            -- upvalues: u47 (upval), u45 (upval), u46 (upval), u42 (upval), fade (upval), u43 (upval)
            u47 = a1 ~= false
            local v1 = if not u47 then nil else u45
            if v1 ~= u46 then
                if v1 ~= nil and u42[v1] == nil then
                    return
                end
                local v2 = u46
                u46 = v1
                if v2 ~= nil then
                    fade(u42[v2], 0)
                end
                if v1 ~= nil then
                    fade(u42[v1], u43[v1])
                end
            end
        end)))
        a1:Add(function() -- Line: 95
            -- upvalues: MusicDirector (upval), u42 (upval), u44 (upval), TweenService (upval), u41 (upval)
            -- upvalues: Debris (upval), u43 (upval), u45 (upval), u46 (upval)
            local Time, v1, v2
            MusicDirector.SetEventMusic(false)
            local v3 = nil
            local v4 = nil
            for i, j in u42, v3, v4 do
                v1 = u44[j]
                if v1 then
                    v1:Cancel()
                end
                TweenService:Create(j, u41, {Volume = 0}):Play()
                v2 = Debris
                Time = u41.Time
                v2:AddItem(j, Time)
            end
            table.clear(u42)
            table.clear(u43)
            table.clear(u44)
            u45 = nil
            u46 = nil
        end)
    end,
    Play = function(a1) -- Line: 113
        -- upvalues: Music (val), MusicDirector (val), u45 (ref), u47 (ref), u46 (ref), u42 (val), fade (val), u43 (val)
        local v1 = ("No Beanstalk music track named %*"):format(a1)
        assert(Music:FindFirstChild(a1) ~= nil, v1)
        MusicDirector.SetEventMusic(true)
        local v2 = if not u47 then nil else a1
        if v2 ~= u46 then
            if v2 ~= nil and u42[v2] == nil then
                return
            end
            local v3 = u46
            u46 = v2
            if v3 ~= nil then
                fade(u42[v3], 0)
            end
            if v2 ~= nil then
                fade(u42[v2], u43[v2])
            end
        end
    end,
    Release = function() -- Line: 121
        -- upvalues: u45 (ref), u47 (ref), u46 (ref), u42 (val), fade (val), u43 (val), MusicDirector (val)
        u45 = nil
        local v1 = if not u47 then nil else u45
        if v1 ~= u46 then
            if v1 == nil or u42[v1] ~= nil then
                local v2 = u46
                u46 = v1
                if v2 ~= nil then
                    fade(u42[v2], 0)
                end
                if v1 ~= nil then
                    fade(u42[v1], u43[v1])
                end
            end
        end
        MusicDirector.SetEventMusic(false)
    end,
}