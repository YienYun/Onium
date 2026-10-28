-- Script path: ReplicatedStorage.Controllers.Game.SewerCaveController.Transition.Score
-- Decompile time: 5.97 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local Audio = require(ReplicatedStorage.Shared.Audio)
local Preload = require(ReplicatedStorage.Shared.Utils.Preload)
require(ReplicatedStorage.Packages.Trove)
local u30 = table.freeze({
    Splash = "rbxassetid://83099379619955",
    Swoosh = "rbxassetid://3755636638",
    Riser = "rbxassetid://101937236820642",
    Suck = "rbxassetid://99901482459638",
    Hole = "rbxassetid://125113804733808",
    Thump = "rbxassetid://92084213757630",
    Whoosh = "rbxassetid://9113077334",
    Crash = "rbxassetid://9119476512",
    Boom = "rbxassetid://119977062667102",
    Shimmer = "rbxassetid://124699703411879",
    Gulp = "rbxassetid://131399570890370",
    Clank = "rbxassetid://99717307993581",
    Giggle = "rbxassetid://119971884687987",
    Pop = "rbxassetid://93817075797663",
    Blub = "rbxassetid://116679049118113",
    Bubbles = "rbxassetid://85713586313967",
    Drone = "rbxassetid://105183066006241",
    Pad = "rbxassetid://136332867876820",
    Gasp = "rbxassetid://80277880055735",
    Pour = "rbxassetid://72104621631194",
    ScoopLong = "rbxassetid://103136552142912",
    ScoopShort = "rbxassetid://118863852017406",
    Flush = "rbxassetid://101426935773542",
    Drip = "rbxassetid://88945982118702",
})
local u31 = {Ids = u30}

local function equalizer(a1, a2, a3) -- Line: 67 -- types: a1: number, a2: number, a3: number
    local EqualizerSoundEffect = Instance.new("EqualizerSoundEffect")
    EqualizerSoundEffect.LowGain = a1
    EqualizerSoundEffect.MidGain = a2
    EqualizerSoundEffect.HighGain = a3
    return EqualizerSoundEffect
end

local function bus(a1) -- Line: 75 -- upvalues: SoundService (val)
    local SoundGroup = Instance.new("SoundGroup")
    SoundGroup.Name = "SewerDrain"
    SoundGroup.Volume = 1
    local Gameplay = SoundService:FindFirstChild("Gameplay")
    SoundGroup.Parent = if Gameplay == nil then SoundService else if not Gameplay:IsA("SoundGroup") then SoundService else Gameplay
    return a1:Add(SoundGroup)
end

local function duck(a1) -- Line: 84 -- upvalues: SoundService (val)
    local Music = SoundService:FindFirstChild("Music")
    if Music ~= nil and Music:IsA("SoundGroup") then
        local EqualizerSoundEffect = Instance.new("EqualizerSoundEffect")
        EqualizerSoundEffect.LowGain = 0
        EqualizerSoundEffect.MidGain = 0
        EqualizerSoundEffect.HighGain = 0
        local v1 = a1:Add(EqualizerSoundEffect)
        v1.Name = "SewerDrainDuck"
        v1.Parent = Music
        return v1
    end
    return nil
end

local function fadeEffect(a1, a2, a3) -- Line: 95
    -- upvalues: TweenService (val)
    if a1 == nil then
        return
    end
    TweenService:Create(a1, TweenInfo.new(a3), a2):Play()
end

function u31.Warm() -- Line: 106 -- upvalues: u30 (val), Preload (val)
    local v1 = {}
    for i, j in u30 do
        table.insert(v1, j)
    end
    task.spawn(Preload.WarmSounds, v1)
end

function u31.Build(a1) -- Line: 114 -- upvalues: bus (val), SoundService (val)
    local v1
    local v2 = bus(a1)
    local EqualizerSoundEffect = Instance.new("EqualizerSoundEffect")
    EqualizerSoundEffect.LowGain = 0
    EqualizerSoundEffect.MidGain = 0
    EqualizerSoundEffect.HighGain = 0
    EqualizerSoundEffect.Name = "Muffle"
    EqualizerSoundEffect.Parent = v2
    local ReverbSoundEffect = Instance.new("ReverbSoundEffect")
    ReverbSoundEffect.Name = "Cave"
    ReverbSoundEffect.DecayTime = 2.2
    ReverbSoundEffect.Density = 1
    ReverbSoundEffect.Diffusion = 1
    ReverbSoundEffect.DryLevel = 0
    ReverbSoundEffect.WetLevel = -80
    ReverbSoundEffect.Parent = v2
    local CompressorSoundEffect = Instance.new("CompressorSoundEffect")
    CompressorSoundEffect.Threshold = -14
    CompressorSoundEffect.Ratio = 3
    CompressorSoundEffect.Attack = 0.01
    CompressorSoundEffect.Release = 0.25
    CompressorSoundEffect.Parent = v2
    local v3 = {Trove = a1, Bus = v2, Muffle = EqualizerSoundEffect, Cave = ReverbSoundEffect}
    local v4 = SoundService:FindFirstChild("Music")
    if v4 == nil then
        v1 = nil
    elseif v4:IsA("SoundGroup") then
        local EqualizerSoundEffect_2 = Instance.new("EqualizerSoundEffect")
        EqualizerSoundEffect_2.LowGain = 0
        EqualizerSoundEffect_2.MidGain = 0
        EqualizerSoundEffect_2.HighGain = 0
        local v5 = a1:Add(EqualizerSoundEffect_2)
        v5.Name = "SewerDrainDuck"
        v5.Parent = v4
        v1 = v5
    else
        v1 = nil
    end
    v3.Duck = v1
    v3.Loops = {}
    v3.Random = Random.new()
    return v3
end

function u31:Play(a2, a3, a4, a5) -- Line: 144
    -- upvalues: u30 (val), Audio (val)
    local v1 = u30[a2]
    if v1 == nil then
        return nil
    end
    return Audio.Play(v1, script, {SoundGroup = self.Bus, Volume = a3, PlaybackSpeed = a4 or 1, TimePosition = a5})
end

function u31.Loop(a1, a2, a3, a4) -- Line: 163
    -- upvalues: u30 (val), Audio (val)
    local v1 = a1.Loops[a2]
    if v1 ~= nil then
        v1.Volume = a3
        v1.PlaybackSpeed = a4 or v1.PlaybackSpeed
        return v1
    end
    v1 = u30[a2]
    if v1 == nil then
        return nil
    end
    local v2 = Audio.Play(v1, script, {
        Deferred = true,
        Looped = true,
        SoundGroup = a1.Bus,
        Volume = a3,
        PlaybackSpeed = a4 or 1,
    })
    if v2 == nil then
        return nil
    end
    a1.Trove:Add(v2)
    a1.Loops[a2] = v2
    v2:Play()
    return v2
end

function u31.Level(a1, a2, a3, a4) -- Line: 190 -- types: a1: table, a2: string, a3: number, a4: number?
    local v1 = a1.Loops[a2]
    if v1 == nil then
        return
    end
    v1.Volume = a3
    if a4 then
        v1.PlaybackSpeed = a4
    end
end

function u31.Fade(a1, a2, a3, a4) -- Line: 201
    -- upvalues: TweenService (val)
    local v1 = a1.Loops[a2]
    if v1 == nil then
        return
    end
    TweenService:Create(v1, TweenInfo.new(a4), {Volume = a3}):Play()
end

function u31:Stop(a2) -- Line: 209 -- types: self: table, a2: string
    local v1 = self.Loops[a2]
    if v1 == nil then
        return
    end
    self.Loops[a2] = nil
    v1:Stop()
    v1:Destroy()
end

function u31.StopAll(a1) -- Line: 219 -- upvalues: u31 (val) -- types: a1: table
    for i in a1.Loops do
        u31.Stop(a1, i)
    end
    local Riser = a1.Riser
    a1.Riser = nil
    if Riser ~= nil then
        Riser:Stop()
    end
end

function u31.Duck(a1, a2, a3) -- Line: 230 -- upvalues: TweenService (val) -- types: a1: table, a2: boolean, a3: number
    local v1
    local Duck = a1.Duck
    local v2 = {LowGain = if not a2 then 0 else -30, MidGain = v1, HighGain = v1}
    if Duck == nil then
        return
    end
    TweenService:Create(Duck, TweenInfo.new(a3), v2):Play()
end

function u31.Under(a1, a2, a3) -- Line: 235 -- upvalues: TweenService (val) -- types: a1: table, a2: boolean, a3: number
    local Muffle = a1.Muffle
    local v1 = {
        HighGain = if not a2 then 0 else -28,
        MidGain = if not a2 then 0 else -8,
        LowGain = if not a2 then 0 else 2,
    }
    if Muffle == nil then
        return
    end
    TweenService:Create(Muffle, TweenInfo.new(a3), v1):Play()
end

function u31.Echo(a1, a2) -- Line: 245 -- types: a1: table, a2: boolean
    local v1 = if not a2 then -80 else -7
    a1.Cave.WetLevel = v1
end

function u31.Rise(a1, a2, a3) -- Line: 249 -- upvalues: u31 (val) -- types: a1: table, a2: number, a3: number
    a1.Riser = u31.Play(a1, "Riser", a3, 1.35, (math.max(3.3 - a2 * 1.35, 0)))
end

function u31.Hush(a1, a2, a3) -- Line: 255 -- types: a1: table, a2: number, a3: table?
    local v1 = a3 or {}
    for i, j in a1.Loops do
        if table.find(v1, i) == nil then
            local Volume = j.Volume
            j.Volume = 0
            a1.Trove:Add((task.delay(a2, function() -- Line: 261 -- upvalues: a1 (val), i (val), j (val), Volume (val)
                if a1.Loops[i] == j and j.Volume == 0 then
                    j.Volume = Volume
                end
            end)))
        end
    end
end

return table.freeze(u31)