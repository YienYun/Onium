-- Script path: ReplicatedStorage.Controllers.Game.BanjoCricketController.Dream.Score
-- Decompile time: 18.42 ms

local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local BanjoCricket = require(ReplicatedStorage.Data.BanjoCricket)
local Preload = require(ReplicatedStorage.Shared.Utils.Preload)
require(ReplicatedStorage.Packages.Trove)
local u45 = NumberRange.new(0.26, 0.42)
local u46 = {0.5, 1, 1, 2}
local v1 = {}

local function effect(a1, a2) -- Line: 98 -- types: a1: userdata?, a2: userdata
    if a1 then
        a2.Parent = a1
        return
    end
    a2:Destroy()
end

local function reverb(a1, a2, a3) -- Line: 106 -- types: a1: number, a2: number, a3: number
    local ReverbSoundEffect = Instance.new("ReverbSoundEffect")
    ReverbSoundEffect.DecayTime = a1
    ReverbSoundEffect.Density = 1
    ReverbSoundEffect.Diffusion = 1
    ReverbSoundEffect.DryLevel = a2
    ReverbSoundEffect.WetLevel = a3
    return ReverbSoundEffect
end

local function equalizer(a1, a2, a3) -- Line: 120 -- types: a1: number, a2: number, a3: number
    local EqualizerSoundEffect = Instance.new("EqualizerSoundEffect")
    EqualizerSoundEffect.LowGain = a1
    EqualizerSoundEffect.MidGain = a2
    EqualizerSoundEffect.HighGain = a3
    return EqualizerSoundEffect
end

local function layer(a1, a2, a3, a4) -- Line: 132
    -- upvalues: Audio (val)
    local v1 = Audio.Play(a2, script, {
        Deferred = true,
        Volume = 0,
        Looped = a3,
        PlaybackSpeed = a4,
        SoundGroup = a1.Bus,
    })
    if v1 then
        a1.Trove:Add(v1)
    end
    return v1
end

local function play(a1, a2, a3) -- Line: 151 -- types: a1: userdata?, a2: number, a3: number?
    if a1 == nil then
        return
    end
    a1.Volume = a2
    a1.TimePosition = a3 or 0
    a1:Play()
end

local function setVolume(a1, a2) -- Line: 160 -- types: a1: userdata?, a2: number
    if a1 then
        a1.Volume = a2
    end
end

local function setSpeed(a1, a2) -- Line: 166 -- types: a1: userdata?, a2: number
    if a1 then
        a1.PlaybackSpeed = a2
    end
end

local function smooth(a1) -- Line: 172 -- types: a1: number
    local v1 = math.clamp(a1, 0, 1)
    return v1 * v1 * (3 - v1 * 2)
end

local function bandSong() -- Line: 179 -- upvalues: CollectionService (val), BanjoCricket (val), Workspace (val)
    for i, j in CollectionService:GetTagged(BanjoCricket.Tags.Music) do
        if j:IsDescendantOf(Workspace) then
            for k, n in j:GetDescendants() do
                if n:IsA("Sound") and n.IsPlaying and n.SoundId == BanjoCricket.Sounds.Band then
                    return n
                end
            end
        end
    end
    return nil
end

local function bus(a1) -- Line: 197 -- upvalues: SoundService (val)
    local SoundGroup = Instance.new("SoundGroup")
    SoundGroup.Name = "BanjoDream"
    SoundGroup.Volume = 1
    local Gameplay = SoundService:FindFirstChild("Gameplay")
    SoundGroup.Parent = if not Gameplay then SoundService else if not Gameplay:IsA("SoundGroup") then SoundService else Gameplay
    return a1:Add(SoundGroup)
end

local function duck(a1) -- Line: 210 -- upvalues: SoundService (val)
    local Music = SoundService:FindFirstChild("Music")
    if Music ~= nil and Music:IsA("SoundGroup") then
        local EqualizerSoundEffect = Instance.new("EqualizerSoundEffect")
        EqualizerSoundEffect.LowGain = 0
        EqualizerSoundEffect.MidGain = 0
        EqualizerSoundEffect.HighGain = 0
        local v1 = a1:Add(EqualizerSoundEffect)
        v1.Name = "BanjoDreamDuck"
        v1.Parent = Music
        return v1
    end
    return nil
end

local function fadeDuck(a1, a2, a3) -- Line: 221
    -- upvalues: TweenService (val)
    local Duck = a1.Duck
    if Duck == nil then
        return
    end
    TweenService:Create(Duck, TweenInfo.new(a3), {LowGain = a2, MidGain = a2, HighGain = a2}):Play()
end

function v1.Build(a1) -- Line: 233 -- upvalues: SoundService (val), layer (val), BanjoCricket (val)
    local EchoSoundEffect, ReverbSoundEffect_5, v1, v2
    local EqualizerSoundEffect = Instance.new("EqualizerSoundEffect")
    EqualizerSoundEffect.LowGain = 0
    EqualizerSoundEffect.MidGain = 0
    EqualizerSoundEffect.HighGain = 0
    EqualizerSoundEffect.Name = "Muffle"
    local v3 = {NextPing = 0, Born = false, Trove = a1}
    local SoundGroup = Instance.new("SoundGroup")
    SoundGroup.Name = "BanjoDream"
    SoundGroup.Volume = 1
    local Gameplay = SoundService:FindFirstChild("Gameplay")
    SoundGroup.Parent = if not Gameplay then SoundService else if not Gameplay:IsA("SoundGroup") then SoundService else Gameplay
    v3.Bus = a1:Add(SoundGroup)
    v3.Muffle = EqualizerSoundEffect
    local Music = SoundService:FindFirstChild("Music")
    if Music == nil then
        v1 = nil
    elseif Music:IsA("SoundGroup") then
        local EqualizerSoundEffect_2 = Instance.new("EqualizerSoundEffect")
        EqualizerSoundEffect_2.LowGain = 0
        EqualizerSoundEffect_2.MidGain = 0
        EqualizerSoundEffect_2.HighGain = 0
        v2 = a1:Add(EqualizerSoundEffect_2)
        v2.Name = "BanjoDreamDuck"
        v2.Parent = Music
        v1 = v2
    else
        v1 = nil
    end
    v3.Duck = v1
    v3.Echoes = {}
    v3.EchoSpeeds = {}
    v3.Strings = {}
    v3.Random = Random.new()
    EqualizerSoundEffect.Parent = v3.Bus
    local v4 = Instance.new("CompressorSoundEffect")
    v4.Threshold = -14
    v4.Ratio = 3
    v4.Attack = 0.01
    v4.Release = 0.25
    v4.Parent = v3.Bus
    v3.Drone = layer(v3, BanjoCricket.Sounds.BanjoLoop, true, 0.62)
    v4 = Instance.new("FlangeSoundEffect")
    v4.Depth = 0.6
    v4.Mix = 0.75
    v4.Rate = 0.35
    local Drone = v3.Drone
    if not Drone then
        v4:Destroy()
    else
        v4.Parent = Drone
    end
    v4 = Instance.new("TremoloSoundEffect")
    v4.Depth = 0.55
    v4.Duty = 0.5
    v4.Frequency = 5
    local Drone_2 = v3.Drone
    if not Drone_2 then
        v4:Destroy()
    else
        v4.Parent = Drone_2
    end
    local Drone_3 = v3.Drone
    local ReverbSoundEffect = Instance.new("ReverbSoundEffect")
    ReverbSoundEffect.DecayTime = 3.5
    ReverbSoundEffect.Density = 1
    ReverbSoundEffect.Diffusion = 1
    ReverbSoundEffect.DryLevel = -4
    ReverbSoundEffect.WetLevel = -2
    if not Drone_3 then
        ReverbSoundEffect:Destroy()
    else
        ReverbSoundEffect.Parent = Drone_3
    end
    v3.Swell = layer(v3, BanjoCricket.Sounds.BanjoLoop, true, 0.8)
    local Swell = v3.Swell
    local ReverbSoundEffect_2 = Instance.new("ReverbSoundEffect")
    ReverbSoundEffect_2.DecayTime = 4
    ReverbSoundEffect_2.Density = 1
    ReverbSoundEffect_2.Diffusion = 1
    ReverbSoundEffect_2.DryLevel = -80
    ReverbSoundEffect_2.WetLevel = 0
    if not Swell then
        ReverbSoundEffect_2:Destroy()
    else
        ReverbSoundEffect_2.Parent = Swell
    end
    v3.Hole = layer(v3, "rbxassetid://125113804733808", true, 0.75)
    v4 = Instance.new("FlangeSoundEffect")
    v4.Depth = 0.4
    v4.Mix = 0.5
    v4.Rate = 1.2
    local Hole = v3.Hole
    if not Hole then
        v4:Destroy()
    else
        v4.Parent = Hole
    end
    v3.Shimmer = layer(v3, "rbxassetid://124699703411879", true, 1)
    local Shimmer = v3.Shimmer
    local ReverbSoundEffect_3 = Instance.new("ReverbSoundEffect")
    ReverbSoundEffect_3.DecayTime = 2.5
    ReverbSoundEffect_3.Density = 1
    ReverbSoundEffect_3.Diffusion = 1
    ReverbSoundEffect_3.DryLevel = -2
    ReverbSoundEffect_3.WetLevel = -6
    if not Shimmer then
        ReverbSoundEffect_3:Destroy()
    else
        ReverbSoundEffect_3.Parent = Shimmer
    end
    v3.Riser = layer(v3, "rbxassetid://101937236820642", false, 1.35)
    v3.Suck = layer(v3, "rbxassetid://99901482459638", false, 1.15)
    v3.Swoosh = layer(v3, "rbxassetid://3755636638", false, 0.75)
    local Swoosh = v3.Swoosh
    local ReverbSoundEffect_4 = Instance.new("ReverbSoundEffect")
    ReverbSoundEffect_4.DecayTime = 2
    ReverbSoundEffect_4.Density = 1
    ReverbSoundEffect_4.Diffusion = 1
    ReverbSoundEffect_4.DryLevel = 0
    ReverbSoundEffect_4.WetLevel = -6
    if not Swoosh then
        ReverbSoundEffect_4:Destroy()
    else
        ReverbSoundEffect_4.Parent = Swoosh
    end
    v3.Lub = layer(v3, "rbxassetid://92084213757630", false, 0.55)
    local Lub = v3.Lub
    local EqualizerSoundEffect_3 = Instance.new("EqualizerSoundEffect")
    EqualizerSoundEffect_3.LowGain = 3
    EqualizerSoundEffect_3.MidGain = -14
    EqualizerSoundEffect_3.HighGain = -40
    if not Lub then
        EqualizerSoundEffect_3:Destroy()
    else
        EqualizerSoundEffect_3.Parent = Lub
    end
    v3.Dub = layer(v3, "rbxassetid://92084213757630", false, 0.64)
    local Dub = v3.Dub
    local EqualizerSoundEffect_4 = Instance.new("EqualizerSoundEffect")
    EqualizerSoundEffect_4.LowGain = 2
    EqualizerSoundEffect_4.MidGain = -14
    EqualizerSoundEffect_4.HighGain = -40
    if not Dub then
        EqualizerSoundEffect_4:Destroy()
    else
        EqualizerSoundEffect_4.Parent = Dub
    end
    v3.Boom = layer(v3, "rbxassetid://119977062667102", false, 1)
    local Boom = v3.Boom
    local EqualizerSoundEffect_5 = Instance.new("EqualizerSoundEffect")
    EqualizerSoundEffect_5.LowGain = 2
    EqualizerSoundEffect_5.MidGain = -4
    EqualizerSoundEffect_5.HighGain = -16
    if not Boom then
        EqualizerSoundEffect_5:Destroy()
    else
        EqualizerSoundEffect_5.Parent = Boom
    end
    v3.Sparkle = layer(v3, "rbxassetid://123855152382706", false, 1)
    v3.Room = layer(v3, BanjoCricket.Sounds.Band, true, 1)
    local v5 = nil
    v2 = nil
    for i, j in BanjoCricket.Mushrooms, v5, v2 do
        v4 = layer(v3, j.Sound, false, j.Speed)
        if v4 then
            EchoSoundEffect = Instance.new("EchoSoundEffect")
            EchoSoundEffect.Delay = 0.22
            EchoSoundEffect.Feedback = 0.55
            EchoSoundEffect.DryLevel = 0
            EchoSoundEffect.WetLevel = -2
            EchoSoundEffect.Parent = v4
            v3.Echoes[i] = v4
            v3.EchoSpeeds[i] = j.Speed
        end
        v4 = layer(v3, j.Sound, false, j.Speed)
        if v4 then
            ReverbSoundEffect_5 = Instance.new("ReverbSoundEffect")
            ReverbSoundEffect_5.DecayTime = 2.5
            ReverbSoundEffect_5.Density = 1
            ReverbSoundEffect_5.Diffusion = 1
            ReverbSoundEffect_5.DryLevel = 0
            ReverbSoundEffect_5.WetLevel = -5
            if not v4 then
                ReverbSoundEffect_5:Destroy()
            else
                ReverbSoundEffect_5.Parent = v4
            end
            v3.Strings[i] = v4
        end
    end
    return v3
end

function v1.Warm() -- Line: 317 -- upvalues: BanjoCricket (val), Preload (val)
    local v1 = {
        BanjoCricket.Sounds.BanjoLoop,
        "rbxassetid://125113804733808",
        "rbxassetid://99901482459638",
        "rbxassetid://101937236820642",
        "rbxassetid://119977062667102",
        "rbxassetid://3755636638",
        "rbxassetid://92084213757630",
        "rbxassetid://124699703411879",
        "rbxassetid://123855152382706",
    }
    for i, j in BanjoCricket.Mushrooms do
        table.insert(v1, j.Sound)
    end
    task.spawn(Preload.WarmSounds, v1)
end

function v1.Fall(a1, a2) -- Line: 337
    -- upvalues: fadeDuck (val), BanjoCricket (val), play (val)
    local v1
    fadeDuck(a1, -30, 0.5)
    local Drone = a1.Drone
    if Drone ~= nil then
        Drone.Volume = 0
        Drone.TimePosition = 0
        Drone:Play()
    end
    local Swell = a1.Swell
    local v2 = a1.Random:NextNumber(0, 9)
    if Swell ~= nil then
        Swell.Volume = 0
        Swell.TimePosition = v2 or 0
        Swell:Play()
    end
    local Suck = a1.Suck
    if Suck ~= nil then
        Suck.Volume = 0.4
        Suck.TimePosition = 0
        Suck:Play()
    end
    local Riser = a1.Riser
    if Riser then
        v2 = math.max(3.3 - a2 * 1.35, 0)
        if Riser ~= nil then
            Riser.Volume = 0.32
            Riser.TimePosition = v2 or 0
            Riser:Play()
        end
    end
    local v3 = #BanjoCricket.Mushrooms
    v2 = v3 - 1
    local v4 = a1
    for i = 0, v2 do
        v1 = v4.Echoes[v3 - i]
        if v1 then
            v4.Trove:Add((task.delay(i * 0.09, play, v1, 0.38)))
        end
    end
end

function v1.Plunge(a1) -- Line: 362 -- types: a1: table
    local Swoosh = a1.Swoosh
    if Swoosh ~= nil then
        Swoosh.Volume = 0.7
        Swoosh.TimePosition = 0
        Swoosh:Play()
    end
    local Swell = a1.Swell
    if Swell then
        Swell.Volume = 0
    end
    local Hole = a1.Hole
    if Hole ~= nil then
        Hole.Volume = 0
        Hole.TimePosition = 0
        Hole:Play()
    end
    local Shimmer = a1.Shimmer
    if Shimmer == nil then
        return
    end
    Shimmer.Volume = 0
    Shimmer.TimePosition = 0
    Shimmer:Play()
end

function v1.Thump(a1, a2) -- Line: 369 -- types: a1: table, a2: boolean
    if a2 then
        local Lub = a1.Lub
        if Lub == nil then
            return
        end
        Lub.Volume = 0.28
        Lub.TimePosition = 0
        Lub:Play()
        return
    end
    local Dub = a1.Dub
    if Dub == nil then
        return
    end
    Dub.Volume = 0.16
    Dub.TimePosition = 0
    Dub:Play()
end

function v1.Wake(a1) -- Line: 378 -- types: a1: table
    local Swell = a1.Swell
    local v1 = a1.Random:NextNumber(0, 9)
    if Swell == nil then
        return
    end
    Swell.Volume = 0
    Swell.TimePosition = v1 or 0
    Swell:Play()
end

function v1.Birth(a1) -- Line: 384
    -- upvalues: play (val), bandSong (val), Audio (val), fadeDuck (val)
    a1.Born = true
    for i, j in {a1.Drone, a1.Swell, a1.Hole, a1.Shimmer} do
        if j then
            j:Stop()
        end
    end
    for k, n in a1.Echoes do
        n:Stop()
    end
    local Trove = a1.Trove
    Trove:Add((task.delay(0.12, function() -- Line: 395 -- upvalues: a1 (val), Trove (val), play (upval)
        local Boom = a1.Boom
        if Boom ~= nil then
            Boom.Volume = 0.28
            Boom.TimePosition = 0
            Boom:Play()
        end
        local Sparkle = a1.Sparkle
        if Sparkle ~= nil then
            Sparkle.Volume = 0.45
            Sparkle.TimePosition = 0
            Sparkle:Play()
        end
        for i, j in a1.Strings do
            Trove:Add((task.delay((i - 1) * 0.05, play, j, 0.5)))
        end
    end)))
    Trove:Add((task.delay(0.35, function() -- Line: 404 -- upvalues: a1 (val), bandSong (upval), Audio (upval)
        local Room = a1.Room
        if Room == nil then
            return
        end
        local v1 = bandSong()
        local TimePosition = if not v1 then 0 else v1.TimePosition
        if Room ~= nil then
            Room.Volume = 0
            Room.TimePosition = TimePosition or 0
            Room:Play()
        end
        Audio.FadeTo(Room, {Volume = 0.26, Seconds = 1.2})
    end)))
    fadeDuck(a1, 0, 1.6)
end

function v1.Release(a1) -- Line: 417 -- upvalues: Audio (val) -- types: a1: table
    local Room = a1.Room
    if Room then
        Audio.FadeTo(Room, {Volume = 0, Seconds = 2.2})
    end
end

function v1.Step(a1, a2) -- Line: 424
    -- upvalues: u45 (val), BanjoCricket (val), u46 (val)
    local v1, v2, v3, v4
    local Time = a2.Time
    if a2.Phase == "Intro" then
        v1 = math.clamp(Time / a2.Length, 0, 1)
        local Drone = a1.Drone
        local v5 = math.clamp(Time / 0.6, 0, 1)
        v3 = v5 * v5 * (3 - v5 * 2) * 0.6
        if Drone then
            Drone.Volume = v3
        end
        local Drone_2 = a1.Drone
        v3 = math.lerp(0.62, 0.36, v1 ^ 1.5)
        if Drone_2 then
            Drone_2.PlaybackSpeed = v3
        end
        local Swell = a1.Swell
        v3 = v1 ^ 3 * 0.9
        if Swell then
            Swell.Volume = v3
        end
        a1.Muffle.HighGain = v1 * -10
        v2 = math.lerp(1, 0.72, v1)
        for k, n in a1.Echoes do
            n.PlaybackSpeed = a1.EchoSpeeds[k] * v2
        end
        return
    end
    if a2.Phase ~= "Ride" then
        if not a1.Born then
            v1 = math.clamp(Time / a2.Length, 0, 1)
            v2 = v1 * v1
            local Drone_5 = a1.Drone
            v4 = (1 - v1) * 0.45
            if Drone_5 then
                Drone_5.Volume = v4
            end
            local Drone_6 = a1.Drone
            v4 = math.lerp(0.46, 1.25, v2)
            if Drone_6 then
                Drone_6.PlaybackSpeed = v4
            end
            local Hole_3 = a1.Hole
            v4 = (1 - v1) * 1.1
            if Hole_3 then
                Hole_3.Volume = v4
            end
            local Hole_4 = a1.Hole
            v4 = math.lerp(0.75, 1.6, v2)
            if Hole_4 then
                Hole_4.PlaybackSpeed = v4
            end
            local Shimmer_2 = a1.Shimmer
            v4 = (1 - v1) * 1.4
            if Shimmer_2 then
                Shimmer_2.Volume = v4
            end
            local Swell_2 = a1.Swell
            v4 = v1 ^ 3 * 0.9
            if Swell_2 then
                Swell_2.Volume = v4
            end
            a1.Muffle.HighGain = (1 - v1) * -3
            return
        end
        a1.Muffle.HighGain = 0
        return
    end
    local Drone_3 = a1.Drone
    if Drone_3 then
        Drone_3.Volume = 0.45
    end
    local Drone_4 = a1.Drone
    v2 = (math.sin(Time * 2.3)) * 0.04 + 0.46
    if Drone_4 then
        Drone_4.PlaybackSpeed = v2
    end
    local Hole = a1.Hole
    local v6 = math.clamp(Time / 0.35, 0, 1)
    v2 = v6 * v6 * (3 - v6 * 2) * 1.1
    if Hole then
        Hole.Volume = v2
    end
    local Hole_2 = a1.Hole
    v2 = (math.sin(Time * 1.7)) * 0.05 + 0.75
    if Hole_2 then
        Hole_2.PlaybackSpeed = v2
    end
    local Shimmer = a1.Shimmer
    v6 = math.clamp(Time / 0.5, 0, 1)
    v2 = v6 * v6 * (3 - v6 * 2) * 1.4
    if Shimmer then
        Shimmer.Volume = v2
    end
    a1.Muffle.HighGain = -3
    local Random = a1.Random
    if a1.NextPing <= Time then
        a1.NextPing = Time + Random:NextNumber(u45.Min, u45.Max)
        v2 = Random:NextInteger(1, #BanjoCricket.Mushrooms)
        v3 = a1.Echoes[v2]
        if v3 then
            v4 = u46[Random:NextInteger(1, #u46)]
            a1.EchoSpeeds[v2] = BanjoCricket.Mushrooms[v2].Speed * v4
            if v3 ~= nil then
                v3.Volume = 0.30400000000000005
                v3.TimePosition = 0
                v3:Play()
            end
        end
    end
    v1 = math.sin(Time * 9) * 0.03 + 1
    for i, j in a1.Echoes do
        j.PlaybackSpeed = a1.EchoSpeeds[i] * v1
    end
end

return table.freeze(v1)