-- Script path: ReplicatedStorage.Controllers.Game.BanjoCricketController.Sounds
-- Decompile time: 3.83 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local Audio = require(ReplicatedStorage.Shared.Audio)
local BanjoCricket = require(ReplicatedStorage.Data.BanjoCricket)
local u28 = require(script.Parent.Mushrooms)
local u29 = nil
local u30 = 0
local v1 = {}

local function play(a1, a2, a3) -- Line: 32
    -- upvalues: BanjoCricket (val), u28 (val), Audio (val)
    local v1 = BanjoCricket.Mushrooms[a1]
    local v2 = u28.Anchor(a1)
    if v1 ~= nil and v2 ~= nil then
        return Audio.Play(v1.Sound, v2, {MaxDistance = 90, PlaybackSpeed = v1.Speed * a2, Volume = a3})
    end
    return nil
end

function v1.Note(a1) -- Line: 45 -- upvalues: play (val), BanjoCricket (val) -- types: a1: number
    play(a1, 1, BanjoCricket.Volume.Note)
end

function v1.Muted(a1) -- Line: 50 -- upvalues: play (val), BanjoCricket (val), TweenService (val) -- types: a1: number
    local u7 = play(a1, 1, BanjoCricket.Volume.Muted)
    if u7 == nil then
        return
    end
    task.delay(0.1, function() -- Line: 55 -- upvalues: TweenService (upval), u7 (val)
        local v1 = TweenService:Create(u7, TweenInfo.new(0.06), {Volume = 0})
        v1.Completed:Once(function() -- Line: 57 -- upvalues: u7 (upval)
            u7:Stop()
        end)
        v1:Play()
    end)
end

function v1.Soft(a1, a2) -- Line: 64 -- upvalues: play (val), BanjoCricket (val) -- types: a1: number, a2: number?
    play(a1, 2 ^ (a2 or 0), BanjoCricket.Volume.Soft)
end

function v1.Fail(a1) -- Line: 68 -- upvalues: u28 (val), Audio (val), BanjoCricket (val) -- types: a1: number
    local v1 = u28.Anchor(a1)
    if v1 == nil then
        return
    end
    Audio.Play(BanjoCricket.Sounds.Fail, v1, {MaxDistance = 90, Volume = BanjoCricket.Volume.Fail})
end

function v1.Run() -- Line: 79 -- upvalues: BanjoCricket (val), play (val)
    for i in BanjoCricket.Mushrooms do
        task.delay((i - 1) * 0.07, play, i, 1, BanjoCricket.Volume.Soft)
    end
end

function v1.Strum() -- Line: 86 -- upvalues: BanjoCricket (val), u28 (val), Audio (val)
    local v1
    local v2 = {MaxDistance = 90, Volume = BanjoCricket.Volume.Strum}
    for i, j in BanjoCricket.Mushrooms do
        v1 = u28.Anchor(i)
        if v1 ~= nil then
            task.delay((i - 1) * 0.045, Audio.Play, j.Sound, v1, v2)
        end
    end
end

function v1.Creak(a1, a2) -- Line: 98 -- upvalues: Audio (val), BanjoCricket (val) -- types: a1: userdata, a2: number
    Audio.Play(BanjoCricket.Sounds.Creak, a1, {
        MaxDistance = 90,
        PlaybackSpeed = 1.1 - a2 * 0.3,
        Volume = BanjoCricket.Volume.Creak * (a2 * 0.5 + 0.5),
    })
end

function v1.Duck(a1) -- Line: 108
    -- upvalues: SoundService (val), u29 (ref), u30 (ref), TweenService (val)
    local Music = SoundService:FindFirstChild("Music")
    if Music ~= nil and Music:IsA("SoundGroup") then
        local v1 = u29
        if v1 == nil or v1.Parent == nil then
            v1 = Instance.new("EqualizerSoundEffect")
            v1.Name = "BanjoCricketDuck"
            v1.HighGain = 0
            v1.MidGain = 0
            v1.LowGain = 0
            v1.Parent = Music
            u29 = v1
        end
        local u22 = v1
        u30 = u30 + 1
        local u25 = u30
        TweenService:Create(u22, TweenInfo.new(0.25), {HighGain = -10, MidGain = -10, LowGain = -10}):Play()
        task.delay(a1, function() -- Line: 131 -- upvalues: u30 (upval), u25 (val), u22 (val), TweenService (upval)
            if u30 == u25 and u22.Parent ~= nil then
                TweenService:Create(u22, TweenInfo.new(0.6), {HighGain = 0, MidGain = 0, LowGain = 0}):Play()
                return
            end
        end)
        return
    end
end

return (table.freeze(v1))