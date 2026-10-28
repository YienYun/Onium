-- Script path: ReplicatedStorage.Client.UI.VFX.Rain
-- Decompile time: 4.17 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Shared.Audio)
local ParticleStage = require(script.Parent.ParticleStage)
local Spread = require(ReplicatedStorage.Shared.Utils.Spread)

local function fade() -- Line: 14
    return NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0, 0),
        NumberSequenceKeypoint.new(0.8, 0, 0),
        (NumberSequenceKeypoint.new(1, 1, 0)),
    })
end

local u20 = {
    Drag = -3.5,
    Enabled = false,
    LightInfluence = 1,
    LockedToPart = true,
    Rate = 70,
    ZOffset = 1,
    EmissionDirection = Enum.NormalId.Top,
}
u20.Lifetime = NumberRange.new(1, 2)
u20.Orientation = Enum.ParticleOrientation.VelocityParallel
u20.RotSpeed = NumberRange.new(-360, 360)
u20.Rotation = NumberRange.new(-45, 45)
u20.ShapeStyle = Enum.ParticleEmitterShapeStyle.Surface
u20.Size = NumberSequence.new(0.25)
u20.Speed = NumberRange.new(-7, -3)
u20.SpreadAngle = Vector2.new(0, 15)
u20.Squash = NumberSequence.new(0)
u20.Transparency = fade()
local Max = u20.Lifetime.Max
local u55 = Random.new()
local v1 = {}

local function orDefault(a1, a2) -- Line: 82
    if a1 == nil then
        return a2
    end
    return a1
end

local function resolveTuning(a1) -- Line: 86 -- upvalues: u20 (val), ParticleStage (val) -- types: a1: table
    local Scale = a1.Scale or {}
    local Rate = u20.Rate
    local Rate_2 = Scale.Rate
    local v1 = Rate * (if Rate_2 ~= nil then Rate_2 else 1) * ParticleStage.QualityBudget()
    local v2 = {}
    local Seconds = a1.Seconds
    v2.seconds = if Seconds ~= nil then Seconds else 2.5
    v2.dropsPerSheet = v1 / #a1.Sheets
    local Speed = Scale.Speed
    v2.speed = if Speed ~= nil then Speed else 1
    local Size = Scale.Size
    v2.size = if Size ~= nil then Size else 1
    local Volume = Scale.Volume
    v2.loudness = if Volume ~= nil then Volume else 1
    return v2
end

local function sheetOverrides(a1, a2) -- Line: 98
    -- upvalues: u20 (val), u55 (val), ParticleStage (val)
    local Speed = u20.Speed
    local v1 = {
        Rate = a2.dropsPerSheet,
        Speed = NumberRange.new(Speed.Min * a2.speed, Speed.Max * a2.speed),
        Texture = a1.Texture,
        ZOffset = u20.ZOffset + u55:NextNumber(-0.06, 0.06),
    }
    if a1.Glow ~= nil then
        v1.LightEmission = a1.Glow
    end
    if a1.SizeMultiplier ~= nil then
        v1.Size = ParticleStage.ScaleSequence(u20.Size, a1.SizeMultiplier)
    end
    return v1
end

local function buildSheet(a1, a2) -- Line: 115
    -- upvalues: ParticleStage (val), u20 (val), sheetOverrides (val)
    local v1 = ParticleStage.Emitter(u20, (sheetOverrides(a1, a2)))
    if a2.size ~= 1 then
        ParticleStage.Scale(v1, a2.size)
    end
    return v1
end

local function playAmbience(a1, a2) -- Line: 123 -- upvalues: Audio (val), Spread (val) -- types: a1: table, a2: number
    Audio.Play(a1.Sounds, script, {PlaybackSpeed = a1.PlaybackSpeed, Volume = Spread.Scale(a1.Volume, a2)})
end

function v1.Fall(a1) -- Line: 130
    -- upvalues: resolveTuning (val), ParticleStage (val), u20 (val), sheetOverrides (val), Audio (val), Spread (val)
    -- upvalues: Max (val)
    local v1
    local v2 = false
    if type(a1) == "table" then
        v2 = type(a1.Sheets) == "table"
    end
    assert(v2, "a rain recipe needs a Sheets list")
    assert(#a1.Sheets > 0, "a rain recipe needs at least one sheet")
    local v3 = resolveTuning(a1)
    local u104 = ParticleStage.new(9, 1.5)
    local v4 = table.create(#a1.Sheets)
    local v5 = nil
    local v6 = nil
    for i, j in a1.Sheets, v5, v6 do
        v1 = ParticleStage.Emitter(u20, (sheetOverrides(j, v3)))
        if v3.size ~= 1 then
            ParticleStage.Scale(v1, v3.size)
        end
        u104:Adopt(v1)
        v4[i] = v1
    end
    local Ambience = a1.Ambience
    if Ambience ~= nil and 0 < v3.loudness then
        local loudness = v3.loudness
        Audio.Play(Ambience.Sounds, script, {
            PlaybackSpeed = Ambience.PlaybackSpeed,
            Volume = Spread.Scale(Ambience.Volume, loudness),
        })
    end
    ParticleStage.SetEnabled(v4, true)
    task.delay(v3.seconds, ParticleStage.SetEnabled, v4, false)
    task.delay(v3.seconds + Max, function() -- Line: 149 -- upvalues: u104 (val)
        u104:Dispose()
    end)
end

return table.freeze(v1)