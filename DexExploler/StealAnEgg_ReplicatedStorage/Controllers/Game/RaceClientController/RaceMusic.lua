-- Script path: ReplicatedStorage.Controllers.Game.RaceClientController.RaceMusic
-- Decompile time: 6.86 ms

local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local MountRace = require(ReplicatedStorage.Data.MountRace)
local MusicDirector = require(ReplicatedStorage.Client.MusicDirector)
local Preferences = require(ReplicatedStorage.Shared.Preferences)
require(ReplicatedStorage.Packages.Trove)
local u40 = TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local u44 = TweenInfo.new(0.15)

local function load(a1) -- Line: 31 -- upvalues: SoundService (val) -- types: a1: userdata
    local v1 = a1:Clone()
    v1.Volume = 0
    v1.Parent = SoundService
    return v1
end

local function pick(a1, a2) -- Line: 39 -- types: a1: userdata?, a2: userdata
    local v1
    if (if a1 == nil then nil else a1:FindFirstChild(a2.Name)) == nil then
        return a2
    end
    assert(v1:IsA("Sound"), (("%* is not a Sound"):format((v1:GetFullName()))))
    return v1
end

local u47 = {}
u47.__index = u47

function u47.Run(a1, a2) -- Line: 67
    -- upvalues: MountRace (val), SoundService (val), u47 (val), MusicDirector (val), Preferences (val)
    -- upvalues: TweenService (val), u40 (val), Debris (val)
    local v1
    local Music = a2:FindFirstChild("Music")
    local v2 = {}
    local PreRaceMusic = MountRace.Sounds.PreRaceMusic
    local v3 = if Music == nil then nil else Music:FindFirstChild(PreRaceMusic.Name)
    if v3 ~= nil then
        assert(v3:IsA("Sound"), (("%* is not a Sound"):format((v3:GetFullName()))))
        v1 = v3
    else
        v1 = PreRaceMusic
    end
    v2.PreRace = v1
    local RaceMusic = MountRace.Sounds.RaceMusic
    v3 = if Music == nil then nil else Music:FindFirstChild(RaceMusic.Name)
    if v3 ~= nil then
        assert(v3:IsA("Sound"), (("%* is not a Sound"):format((v3:GetFullName()))))
        v1 = v3
    else
        v1 = RaceMusic
    end
    v2.Race = v1
    local FinalLapMusic = MountRace.Sounds.FinalLapMusic
    v3 = if Music == nil then nil else Music:FindFirstChild(FinalLapMusic.Name)
    if v3 ~= nil then
        assert(v3:IsA("Sound"), (("%* is not a Sound"):format((v3:GetFullName()))))
        v1 = v3
    else
        v1 = FinalLapMusic
    end
    v2.FinalLap = v1
    local VictoryMusic = MountRace.Sounds.VictoryMusic
    v3 = if Music == nil then nil else Music:FindFirstChild(VictoryMusic.Name)
    if v3 ~= nil then
        assert(v3:IsA("Sound"), (("%* is not a Sound"):format((v3:GetFullName()))))
        v1 = v3
    else
        v1 = VictoryMusic
    end
    v2.Victory = v1
    local v4 = v2.Victory:Clone()
    v4.Volume = 0
    v4.Parent = SoundService
    local v5 = {Wanted = "Race", Enabled = true}
    v3 = {}
    local v6 = v2.PreRace:Clone()
    v6.Volume = 0
    v6.Parent = SoundService
    v3.PreRace = v6
    v6 = v2.Race:Clone()
    v6.Volume = 0
    v6.Parent = SoundService
    v3.Race = v6
    v6 = v2.FinalLap:Clone()
    v6.Volume = 0
    v6.Parent = SoundService
    v3.FinalLap = v6
    v3.Victory = v4
    v5.Sounds = v3
    v5.Volumes = {
        PreRace = v2.PreRace.Volume,
        Race = v2.Race.Volume,
        FinalLap = v2.FinalLap.Volume,
        Victory = v2.Victory.Volume,
    }
    v5.Tweens = {}
    local u167 = setmetatable(v5, u47)
    MusicDirector.SetEventMusic(true)
    a1:Add((Preferences.Observe("Music", function(a1) -- Line: 98 -- upvalues: u167 (val) -- types: a1: boolean?
        u167.Enabled = a1 ~= false
        u167:Apply()
    end)))
    a1:Connect(v4.Ended, function() -- Line: 103 -- upvalues: u167 (val)
        if u167.Wanted == "Victory" then
            u167:Play("Race")
        end
    end)
    a1:Add(function() -- Line: 108
        -- upvalues: MusicDirector (upval), u167 (val), TweenService (upval), u40 (upval), Debris (upval)
        local Time, v1, v2
        MusicDirector.SetEventMusic(false)
        local v3 = nil
        local v4 = nil
        for i, j in u167.Sounds, v3, v4 do
            v1 = u167.Tweens[j]
            if v1 ~= nil then
                v1:Cancel()
            end
            TweenService:Create(j, u40, {Volume = 0}):Play()
            v2 = Debris
            Time = u40.Time
            v2:AddItem(j, Time)
        end
    end)
    u167:Apply()
    return u167
end

function u47:Fade(a2, a3, a4, a5) -- Line: 123
    -- upvalues: TweenService (val), u40 (val)
    local v1 = self.Tweens[a2]
    if v1 ~= nil then
        v1:Cancel()
    end
    if a3 > 0 and not a2.IsPlaying then
        a2.TimePosition = a4 or 0
        a2:Play()
    end
    local u34 = TweenService:Create(a2, a5 or u40, {Volume = a3})
    self.Tweens[a2] = u34
    u34.Completed:Once(function(a1) -- Line: 134 -- upvalues: self (val), a2 (val), u34 (val), a3 (val)
        if self.Tweens[a2] == u34 then
            self.Tweens[a2] = nil
        end
        if a1 == Enum.PlaybackState.Completed and a3 <= 0 then
            a2:Stop()
        end
    end)
    u34:Play()
end

function u47:Apply() -- Line: 145 -- upvalues: u44 (val), u40 (val)
    local Wanted
    if (if not self.Enabled then nil else self.Wanted) == self.Playing then
        self.StartAt = nil
        return
    end
    local Playing = self.Playing
    self.Playing = Wanted
    local v1 = if Playing == "PreRace" then u44 else if Wanted ~= "PreRace" then u40 else u44
    if Playing ~= nil then
        self:Fade(self.Sounds[Playing], 0, nil, v1)
    end
    if Wanted ~= nil then
        local TimePosition = if Playing ~= "Race" then self.StartAt else if Wanted ~= "FinalLap" then self.StartAt else self.Sounds.Race.TimePosition
        self.StartAt = nil
        self:Fade(self.Sounds[Wanted], self.Volumes[Wanted], TimePosition, v1)
    end
end

function u47:Play(a2, a3) -- Line: 167 -- types: a2: string, a3: number?
    self.Wanted = a2
    self.StartAt = a3
    self:Apply()
end

return u47