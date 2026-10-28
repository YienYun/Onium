-- Script path: ReplicatedStorage.Controllers.Game.SewerCaveController.Ambience
-- Decompile time: 4.28 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local Audio = require(ReplicatedStorage.Shared.Audio)
local SewerCave = require(ReplicatedStorage.Shared.Util.SewerCave)
require(ReplicatedStorage.Packages.Trove)
local Markers = SewerCave.Markers
local StoneRoom = Enum.ReverbType.StoneRoom
local u25 = {74697236349743, 104487140689701, 119941771367075}
local u32 = NumberRange.new(3, 9)
local u33 = {0.25, 0.5}
local u36 = {0.85, 1.15}
local u39 = {0.45, 0.9}
local u43 = Random.new()
local v1 = {}

local function dripEcho() -- Line: 37
    local ReverbSoundEffect = Instance.new("ReverbSoundEffect")
    ReverbSoundEffect.DecayTime = 1.8
    ReverbSoundEffect.Density = 0.9
    ReverbSoundEffect.Diffusion = 0.85
    ReverbSoundEffect.DryLevel = 0
    ReverbSoundEffect.WetLevel = -8
    return {ReverbSoundEffect}
end

local function dripPoint() -- Line: 47 -- upvalues: SewerCave (val), Markers (val), u43 (val), u39 (val)
    local v1 = SewerCave.Marker(Markers.Bounds)
    if v1 == nil then
        return nil
    end
    local v2 = v1.Size / 2
    return v1.CFrame:PointToWorldSpace((Vector3.new(u43:NextNumber(-v2.X, v2.X), (u43:NextNumber(u39[1], u39[2])) * v1.Size.Y - v2.Y, (u43:NextNumber(-v2.Z, v2.Z)))))
end

local function drip() -- Line: 61 -- upvalues: dripPoint (val), Audio (val), u25 (val), u43 (val), u33 (val), u36 (val)
    local v1 = dripPoint()
    if v1 == nil then
        return
    end
    local Play = Audio.Play
    local v2 = u25[u43:NextInteger(1, #u25)]
    local v3 = {MaxDistance = 140, Volume = u33, PlaybackSpeed = u36}
    local ReverbSoundEffect = Instance.new("ReverbSoundEffect")
    ReverbSoundEffect.DecayTime = 1.8
    ReverbSoundEffect.Density = 0.9
    ReverbSoundEffect.Diffusion = 0.85
    ReverbSoundEffect.DryLevel = 0
    ReverbSoundEffect.WetLevel = -8
    v3.Effects = {ReverbSoundEffect}
    Play(v2, v1, v3)
end

local function startLoop(a1) -- Line: 74 -- upvalues: SewerCave (val), Audio (val), SoundService (val)
    local v1 = SewerCave.Cave()
    local v2 = v1 and v1:FindFirstChild(SewerCave.AmbienceName)
    if v2 ~= nil and v2:IsA("Sound") then
        local Volume = if not (0 < v2.Volume) then 0.5 else v2.Volume
        local u25 = Audio.Play(v2, SoundService, {Looped = true, Volume = 0})
        if u25 == nil then
            return
        end
        Audio.FadeTo(u25, {Seconds = 2.5, Volume = Volume})
        a1:Add(function() -- Line: 87 -- upvalues: Audio (upval), u25 (val)
            Audio.FadeTo(u25, {Volume = 0, Seconds = 0.8})
            task.delay(0.8500000000000001, function() -- Line: 89 -- upvalues: u25 (upval)
                u25:Destroy()
            end)
        end)
        return
    end
end

local function startReverb(a1) -- Line: 95 -- upvalues: SoundService (val), StoneRoom (val)
    local AmbientReverb = SoundService.AmbientReverb
    SoundService.AmbientReverb = StoneRoom
    a1:Add(function() -- Line: 98 -- upvalues: SoundService (upval), StoneRoom (upval), AmbientReverb (val)
        if SoundService.AmbientReverb == StoneRoom then
            SoundService.AmbientReverb = AmbientReverb
        end
    end)
end

local function startDrips(a1) -- Line: 105 -- upvalues: u43 (val), u32 (val), drip (val)
    a1:Add((task.spawn(function() -- Line: 106 -- upvalues: u43 (upval), u32 (upval), drip (upval)
        while true do
            task.wait(u43:NextNumber(u32.Min, u32.Max))
            drip()
        end
    end)))
end

function v1.Start(a1) -- Line: 118
    -- upvalues: SoundService (val), StoneRoom (val), startLoop (val), u43 (val), u32 (val), drip (val)
    local v1 = a1:Extend()
    local AmbientReverb = SoundService.AmbientReverb
    SoundService.AmbientReverb = StoneRoom
    v1:Add(function() -- Line: 98 -- upvalues: SoundService (upval), StoneRoom (upval), AmbientReverb (val)
        if SoundService.AmbientReverb == StoneRoom then
            SoundService.AmbientReverb = AmbientReverb
        end
    end)
    startLoop(v1)
    v1:Add((task.spawn(function() -- Line: 106 -- upvalues: u43 (upval), u32 (upval), drip (upval)
        while true do
            task.wait(u43:NextNumber(u32.Min, u32.Max))
            drip()
        end
    end)))
end

return table.freeze(v1)