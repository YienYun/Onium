-- Script path: ReplicatedStorage.Controllers.Game.ManorInteriorController.Ambience
-- Decompile time: 4.39 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local Audio = require(ReplicatedStorage.Shared.Audio)
local ManorInterior = require(ReplicatedStorage.Shared.Util.ManorInterior)
require(ReplicatedStorage.Packages.Trove)
local Markers = ManorInterior.Markers
local Sounds = ManorInterior.Sounds
local Hallway = Enum.ReverbType.Hallway
local u26 = {Sounds.Creak, Sounds.FloorCreak}
local u32 = NumberRange.new(5, 14)
local u33 = {0.25, 0.55}
local u36 = {0.85, 1.1}
local u39 = {0.05, 0.6}
local u43 = Random.new()
local v1 = {}

local function creakPoint() -- Line: 36 -- upvalues: ManorInterior (val), Markers (val), u43 (val), u39 (val)
    local v1 = ManorInterior.Marker(Markers.Bounds)
    if v1 == nil then
        return nil
    end
    local v2 = v1.Size / 2
    return v1.CFrame:PointToWorldSpace((Vector3.new(u43:NextNumber(-v2.X, v2.X), (u43:NextNumber(u39[1], u39[2])) * v1.Size.Y - v2.Y, (u43:NextNumber(-v2.Z, v2.Z)))))
end

local function creak() -- Line: 50
    -- upvalues: creakPoint (val), Audio (val), u26 (val), u43 (val), u33 (val), u36 (val)
    local v1 = creakPoint()
    if v1 == nil then
        return
    end
    Audio.Play(u26[u43:NextInteger(1, #u26)], v1, {MaxDistance = 160, Volume = u33, PlaybackSpeed = u36})
end

local function startLoop(a1) -- Line: 62 -- upvalues: Audio (val), Sounds (val), SoundService (val)
    local u7 = Audio.Play(Sounds.Ambience, SoundService, {Looped = true, Volume = 0})
    if u7 == nil then
        return
    end
    Audio.FadeTo(u7, {Volume = 0.45, Seconds = 2.5})
    a1:Add(function() -- Line: 69 -- upvalues: Audio (upval), u7 (val)
        Audio.FadeTo(u7, {Volume = 0, Seconds = 0.8})
        task.delay(0.8500000000000001, function() -- Line: 71 -- upvalues: u7 (upval)
            u7:Destroy()
        end)
    end)
end

local function startReverb(a1) -- Line: 77 -- upvalues: SoundService (val), Hallway (val)
    local AmbientReverb = SoundService.AmbientReverb
    SoundService.AmbientReverb = Hallway
    a1:Add(function() -- Line: 80 -- upvalues: SoundService (upval), Hallway (upval), AmbientReverb (val)
        if SoundService.AmbientReverb == Hallway then
            SoundService.AmbientReverb = AmbientReverb
        end
    end)
end

local function startCreaks(a1) -- Line: 87 -- upvalues: u43 (val), u32 (val), creak (val)
    a1:Add((task.spawn(function() -- Line: 88 -- upvalues: u43 (upval), u32 (upval), creak (upval)
        while true do
            task.wait(u43:NextNumber(u32.Min, u32.Max))
            creak()
        end
    end)))
end

function v1.Start(a1) -- Line: 100
    -- upvalues: SoundService (val), Hallway (val), startLoop (val), u43 (val), u32 (val), creak (val)
    local v1 = a1:Extend()
    local AmbientReverb = SoundService.AmbientReverb
    SoundService.AmbientReverb = Hallway
    v1:Add(function() -- Line: 80 -- upvalues: SoundService (upval), Hallway (upval), AmbientReverb (val)
        if SoundService.AmbientReverb == Hallway then
            SoundService.AmbientReverb = AmbientReverb
        end
    end)
    startLoop(v1)
    v1:Add((task.spawn(function() -- Line: 88 -- upvalues: u43 (upval), u32 (upval), creak (upval)
        while true do
            task.wait(u43:NextNumber(u32.Min, u32.Max))
            creak()
        end
    end)))
end

return table.freeze(v1)