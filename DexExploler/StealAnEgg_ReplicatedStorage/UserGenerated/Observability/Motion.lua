-- Script path: ReplicatedStorage.UserGenerated.Observability.Motion
-- Decompile time: 3.69 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Observability = require(ReplicatedStorage.UserGenerated.Observability)
local Codec = require(ReplicatedStorage.UserGenerated.Observability.Codec)
local Op = Observability.Op
local u15 = {Angular = 1, Linear = 2, Acceleration = 4, SameRotation = 8}

function u15.at(a1, a2, a3, a4, a5) -- Line: 28 -- types: a1: userdata, a2: vector, a3: vector, a4: vector, a5: number
    local v1 = a4 * (a5 * 0.5 * a5)
    local Magnitude = a2.Magnitude
    if Magnitude == 0 then
        return a1 + a3 * a5 + v1
    end
    local v2 = a2 / Magnitude
    local v3 = (a2:Cross(a3)) / (Magnitude * Magnitude)
    local v4 = CFrame.fromAxisAngle(v2, Magnitude * a5)
    return CFrame.new(v3 + v4:VectorToWorldSpace(a1.Position - v3) + v2 * ((v2:Dot(a3)) * a5) + v1) * v4 * a1.Rotation
end

function u15.between(a1, a2, a3) -- Line: 46 -- types: a1: userdata, a2: userdata, a3: number
    local v1 = a2 * a1:Inverse()
    local v2, v3 = v1:ToAxisAngle()
    local Position = v1.Position
    if not (v3 < 1e-06) and not (v2.Magnitude < 1e-06) then
        local Unit = v2.Unit
        v1 = Unit:Dot(Position)
        local v4 = Position - Unit * v1
        local v5 = (v4 + (Unit:Cross(v4)) / math.tan(v3 / 2)) * 0.5
        v4 = Unit * (v3 / a3)
        return v4, Unit * (v1 / a3) - v4:Cross(v5)
    end
    return Vector3.new(0, 0, 0), Position / a3
end

function u15.accelerating(a1, a2, a3, a4, a5, a6) -- Line: 64
    -- upvalues: 
    local v1 = (a2 - a1) / (a5 - a4)
    local v2 = (a3 - a2) / (a6 - a5)
    local v3 = (v2 - v1) / ((a6 - a4) / 2)
    return v2 + v3 * ((a6 - a5) / 2), v3
end

function u15.apart(a1, a2, a3, a4) -- Line: 72 -- types: a1: userdata, a2: userdata, a3: number, a4: number
    local v1
    if a3 < (a1.Position - a2.Position).Magnitude then
        return true
    end
    _, v1 = ((a1.Rotation:Inverse()) * a2.Rotation):ToAxisAngle()
    v1 = math.abs(v1) % 6.283185307179586
    return a4 < math.min(v1, 6.283185307179586 - v1)
end

local function vector(a1, a2) -- Line: 81 -- types: a2: vector
    a1:f32(a2.X)
    a1:f32(a2.Y)
    a1:f32(a2.Z)
end

function u15.write(a1, a2, a3, a4, a5, a6, a7, a8) -- Line: 89
    -- upvalues: u15 (val), Op (val), Codec (val)
    local v1 = (if a5 == Vector3.new(0, 0, 0) then 0 else u15.Angular) + (if a6 == Vector3.new(0, 0, 0) then 0 else u15.Linear)
    local v2 = v1 + (if a7 == Vector3.new(0, 0, 0) then 0 else u15.Acceleration)
    local v3 = v2 + (if not a8 then 0 else u15.SameRotation)
    a1:u8(Op.CFrameMotion)
    Codec.varuint(a1, a2)
    Codec.varuint(a1, a3)
    a1:u8(v3)
    if not a8 then
        Codec.cframe(a1, a4)
    else
        Codec.position(a1, a4)
    end
    if bit32.btest(v3, u15.Angular) then
        a1:f32(a5.X)
        a1:f32(a5.Y)
        a1:f32(a5.Z)
    end
    if bit32.btest(v3, u15.Linear) then
        a1:f32(a6.X)
        a1:f32(a6.Y)
        a1:f32(a6.Z)
    end
    if bit32.btest(v3, u15.Acceleration) then
        a1:f32(a7.X)
        a1:f32(a7.Y)
        a1:f32(a7.Z)
    end
end

return u15