-- Script path: ReplicatedStorage.Client.UI.VFX.Confetti
-- Decompile time: 6.13 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Shared.Audio)
local u14 = require(script.Parent.ParticleStage)
local u18 = NumberRange.new(0.92, 1.08)
local u22 = NumberRange.new(1.8, 2.2)

local function fade() -- Line: 23
    return NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0, 0),
        NumberSequenceKeypoint.new(0.8, 0, 0),
        (NumberSequenceKeypoint.new(1, 1, 0)),
    })
end

local u24 = {
    Drag = -0.5,
    Enabled = false,
    LightInfluence = 1,
    LockedToPart = true,
    Rate = 15,
    Texture = "rbxassetid://104352847228921",
    ZOffset = 2,
    EmissionDirection = Enum.NormalId.Top,
}
u24.Lifetime = NumberRange.new(3, 5)
u24.Orientation = Enum.ParticleOrientation.VelocityParallel
u24.RotSpeed = NumberRange.new(-60, 60)
u24.Rotation = NumberRange.new(-180, 180)
u24.ShapeStyle = Enum.ParticleEmitterShapeStyle.Surface
u24.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.1, 0.03), (NumberSequenceKeypoint.new(1, 0.1, 0.03))})
u24.Speed = NumberRange.new(-3, -1.5)
u24.SpreadAngle = Vector2.new(0, 15)
u24.Squash = NumberSequence.new({NumberSequenceKeypoint.new(0, 0, 1), (NumberSequenceKeypoint.new(1, 0, 1))})
u24.Transparency = fade()
local u76 = {Drag = 2.4}
u76.Speed = NumberRange.new(19, 28)
local Max = u24.Lifetime.Max
local u84 = Random.new()
local u87 = (function() -- Line: 93
    local v1
    local v2 = table.create(5)
    for i = 1, 5 do
        v1 = ((i - 1) * 0.618033988749895 + 0.74) % 1
        v2[i] = (Color3.fromHSV(v1, 0.66, 1))
    end
    return v2
end)()

local function orDefault(a1, a2) -- Line: 104
    if a1 == nil then
        return a2
    end
    return a1
end

local function resolveTuning(a1) -- Line: 108 -- upvalues: u87 (val) -- types: a1: table
    local Opening = a1.Opening or {}
    local Scale = a1.Scale or {}
    local v1 = {}
    local Seconds = a1.Seconds
    v1.streamSeconds = if Seconds ~= nil then Seconds else 4.5
    local Palette = a1.Palette
    v1.swatches = if Palette ~= nil then Palette else u87
    v1.texture = if a1.Texture == nil then nil else if a1.Texture == "" then nil else a1.Texture
    local Pop = Opening.Pop
    v1.pops = if Pop ~= nil then Pop else true
    local Sound = Opening.Sound
    v1.audible = if Sound ~= nil then Sound else true
    local Rate = Scale.Rate
    v1.rate = if Rate ~= nil then Rate else 1
    local Size = Scale.Size
    v1.size = if Size ~= nil then Size else 1
    local Speed = Scale.Speed
    v1.speed = if Speed ~= nil then Speed else 1
    local Volume = Scale.Volume
    v1.loudness = if Volume ~= nil then Volume else 1
    return v1
end

local function layerOverrides(a1, a2, a3) -- Line: 124
    -- upvalues: u84 (val), u24 (val)
    local v1 = a2.speed * (1 + u84:NextNumber(-0.08, 0.08))
    local Speed = u24.Speed
    local v2 = {
        Color = ColorSequence.new(a1),
        Rate = u24.Rate * a2.rate * a3,
        Speed = NumberRange.new(Speed.Min * v1, Speed.Max * v1),
        ZOffset = u24.ZOffset + u84:NextNumber(-0.07, 0.07),
    }
    if a2.texture ~= nil then
        v2.Texture = a2.texture
    end
    return v2
end

local function buildStreamer(a1, a2, a3) -- Line: 139
    -- upvalues: u14 (val), u24 (val), layerOverrides (val)
    local v1 = u14.Emitter(u24, (layerOverrides(a1, a2, a3)))
    if a2.size ~= 1 then
        u14.Scale(v1, a2.size)
    end
    return v1
end

local function throwPop(a1, a2, a3, a4) -- Line: 147
    -- upvalues: layerOverrides (val), u76 (val), u14 (val), u24 (val)
    local v1 = math.round(a3.rate * 100 * a4)
    if v1 < 1 then
        return
    end
    local v2 = layerOverrides(a2, a3, a4)
    for i, j in u76 do
        v2[i] = j
    end
    local v3 = u14.Emitter(u24, v2)
    if a3.size ~= 1 then
        u14.Scale(v3, a3.size)
    end
    a1:Adopt(v3)
    v3:Emit(v1)
end

local function ringPop(a1) -- Line: 164 -- upvalues: Audio (val), u84 (val), u18 (val), u22 (val) -- types: a1: number
    Audio.Play("rbxassetid://135524199765808", script, {
        PlaybackSpeed = u84:NextNumber(u18.Min, u18.Max),
        Volume = u84:NextNumber(u22.Min, u22.Max) * a1,
    })
end

return table.freeze({
    Burst = function(a1) -- Line: 173
        -- upvalues: resolveTuning (val), u14 (val), u24 (val), layerOverrides (val), throwPop (val), ringPop (val)
        -- upvalues: Max (val)
        local v1
        local v2 = true
        if a1 ~= nil then
            v2 = type(a1) == "table"
        end
        assert(v2, "a confetti recipe must be a table when given")
        local v3 = resolveTuning(a1 or {})
        v2 = u14.QualityBudget()
        local u116 = u14.new(5.5, 1.25)
        local v4 = table.create(#v3.swatches)
        local v5 = nil
        local v6 = nil
        for i, j in v3.swatches, v5, v6 do
            v1 = u14.Emitter(u24, (layerOverrides(j, v3, v2)))
            if v3.size ~= 1 then
                u14.Scale(v1, v3.size)
            end
            u116:Adopt(v1)
            v4[i] = v1
        end
        local v7 = 0
        if v3.pops then
            v7 = 0.6
            for k, n in v3.swatches do
                throwPop(u116, n, v3, v2)
            end
            if v3.audible and 0 < v3.loudness then
                ringPop(v3.loudness)
            end
        end
        v2 = v7 + v3.streamSeconds
        task.delay(v7, u14.SetEnabled, v4, true)
        task.delay(v2, u14.SetEnabled, v4, false)
        task.delay(v2 + Max, function() -- Line: 201 -- upvalues: u116 (val)
            u116:Dispose()
        end)
    end,
})