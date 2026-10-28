-- Script path: ReplicatedStorage.Packages._Index.sleitnick_ez_shake@unknown.CameraShaker.CameraShakePresets
-- Decompile time: 2.10 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local u14 = require(script.Parent.CameraShakeInstance)
local u15 = {}

function u15.Bump() -- Line: 35 -- upvalues: u14 (val)
    local v1 = u14.new(2.5, 4, 0.1, 0.75)
    v1.PositionInfluence = Vector3.new(0.15000000596046448, 0.15000000596046448, 0.15000000596046448)
    v1.RotationInfluence = Vector3.new(1, 1, 1)
    return v1
end

function u15.Explosion() -- Line: 44 -- upvalues: u14 (val)
    local v1 = u14.new(5, 10, 0, 1.5)
    v1.PositionInfluence = Vector3.new(0.25, 0.25, 0.25)
    v1.RotationInfluence = Vector3.new(4, 1, 1)
    return v1
end

function u15.Earthquake() -- Line: 53 -- upvalues: u14 (val)
    local v1 = u14.new(0.6, 3.5, 2, 10)
    v1.PositionInfluence = Vector3.new(0.25, 0.25, 0.25)
    v1.RotationInfluence = Vector3.new(1, 1, 4)
    return v1
end

function u15.BadTrip() -- Line: 62 -- upvalues: u14 (val)
    local v1 = u14.new(10, 0.15, 5, 10)
    v1.PositionInfluence = Vector3.new(0, 0, 0.15000000596046448)
    v1.RotationInfluence = Vector3.new(2, 1, 4)
    return v1
end

function u15.HandheldCamera() -- Line: 71 -- upvalues: u14 (val)
    local v1 = u14.new(1, 0.25, 5, 10)
    v1.PositionInfluence = Vector3.new(0, 0, 0)
    v1.RotationInfluence = Vector3.new(1, 0.5, 0.5)
    return v1
end

function u15.Vibration() -- Line: 80 -- upvalues: u14 (val)
    local v1 = u14.new(0.4, 20, 2, 2)
    v1.PositionInfluence = Vector3.new(0, 0.15000000596046448, 0)
    v1.RotationInfluence = Vector3.new(1.25, 0, 4)
    return v1
end

function u15.RoughDriving() -- Line: 89 -- upvalues: u14 (val)
    local v1 = u14.new(1, 2, 1, 1)
    v1.PositionInfluence = Vector3.new(0, 0, 0)
    v1.RotationInfluence = Vector3.new(1, 1, 1)
    return v1
end

function u15.WeakEarthquake() -- Line: 96 -- upvalues: u14 (val)
    local v1 = u14.new(0.3, 1.5, 1, 5)
    v1.PositionInfluence = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224)
    v1.RotationInfluence = Vector3.new(0.5, 0.5, 1)
    return v1
end

return (setmetatable({
    _allPresetsLiteral = t.union(
        t.literal("Bump"),
        t.literal("Explosion"),
        t.literal("Earthquake"),
        t.literal("BadTrip"),
        t.literal("HandheldCamera"),
        t.literal("Vibration"),
        t.literal("RoughDriving")
    ),
}, {
    __index = function(a1, a2) -- Line: 115 -- upvalues: u15 (val)
        local v1 = u15[a2]
        if type(v1) == "function" then
            return v1()
        end
        error("No preset found with index \"" .. a2 .. "\"")
    end,
}))