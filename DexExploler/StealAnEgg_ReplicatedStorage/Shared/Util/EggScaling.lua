-- Script path: ReplicatedStorage.Shared.Util.EggScaling
-- Decompile time: 3.52 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EventEggCategories = require(ReplicatedStorage.Shared.Util.EventEggCategories)
local t = require(ReplicatedStorage.Packages.t)
local ModelBounds = require(ReplicatedStorage.Shared.Utils.ModelBounds)
local u27 = t.intersection(t.numberMinExclusive((-1 / 0)), t.numberMaxExclusive((1 / 0)))
local u31 = t.strict(u27)
local u34 = t.strict(function(a1) -- Line: 15 -- upvalues: u27 (val)
    if typeof(a1) ~= "Vector3" then
        return false
    end
    return u27(a1.X) and u27(a1.Y) and u27(a1.Z)
end)
local u40 = t.strict(t.optional(t.string))
local u45 = t.strict(t.instanceIsA("Model"))
local u46 = {}

function u46.ClampSaved(a1) -- Line: 46 -- upvalues: u31 (val) -- types: a1: number
    u31(a1)
    return (math.clamp(a1, 0.002, 200))
end

function u46.FloorForCategory(a1, a2) -- Line: 52
    -- upvalues: u31 (val), u40 (val), EventEggCategories (val)
    u31(a1)
    u40(a2)
    if EventEggCategories.IsEventEgg(a2) then
        return a1 * 1
    end
    return a1 * 0.6
end

function u46.RawVisual(a1, a2) -- Line: 63 -- upvalues: u31 (val) -- types: a1: number, a2: number
    u31(a1)
    u31(a2)
    return a1 * math.max(a2, 0.002)
end

function u46.LiftToFloor(a1, a2, a3) -- Line: 70
    -- upvalues: u31 (val), u46 (val)
    u31(a1)
    u31(a2)
    return (math.max(u46.FloorForCategory(a1, a3), a2))
end

function u46.PreGrowthVisual(a1, a2, a3) -- Line: 77
    -- upvalues: u46 (val)
    return (math.clamp(u46.RawVisual(a1, a2), u46.FloorForCategory(a1, a3), a1 * 8))
end

function u46.PlacedStart(a1, a2, a3) -- Line: 89 -- upvalues: u46 (val) -- types: a1: number, a2: number, a3: string?
    return u46.PreGrowthVisual(a1, a2, a3)
end

function u46.PlacedTarget(a1, a2, a3) -- Line: 97 -- upvalues: u46 (val) -- types: a1: number, a2: number, a3: string?
    local v1 = u46.RawVisual(a1, a2)
    local v2 = u46.FloorForCategory(a1, a3)
    if v1 < v2 then
        return v2
    end
    return v1 * 3
end

function u46.FitInside(a1, a2) -- Line: 111
    -- upvalues: u45 (val), u34 (val), ModelBounds (val), u46 (val)
    local v1
    u45(a1)
    u34(a2)
    _, v1 = ModelBounds(a1)
    return u46.ClampSaved(a1:GetScale() * (math.min(a2.X / math.max(v1.X, 0.002), a2.Y / math.max(v1.Y, 0.002), a2.Z / (math.max(v1.Z, 0.002))) * 0.92))
end

u46.MIN_EGG_SCALE = 0.8
u46.MAX_EGG_SCALE = 3
u46.MIN_ICON_SCALE = 0.5
u46.MAX_ICON_SCALE = 1.1

function u46.IconScaleFor(a1) -- Line: 130 -- types: a1: number?
    if typeof(a1) ~= "number" then
        return 1.1
    end
    if a1 == a1 and not (a1 <= 0) then
        return (math.clamp(a1, 0.8, 3) - 0.8) / 2.2 * 0.6000000000000001 + 0.5
    end
    return 1.1
end

function u46.FitIconToEgg(a1, a2) -- Line: 146 -- upvalues: u46 (val) -- types: a1: userdata, a2: number?
    local v1 = u46.IconScaleFor(a2)
    a1.Size = UDim2.fromScale(v1, v1)
end

return u46