-- Script path: ReplicatedStorage.Controllers.Game.Plots.ActiveAssetsController.AssetWanderMotion
-- Decompile time: 4.95 ms

local AssetWanderArea = require(script.Parent.AssetWanderArea)
local u5 = {}

function u5.YawFromFlatDirection(a1) -- Line: 18 -- types: a1: vector
    return (math.atan2(-a1.X, -a1.Z))
end

function u5.ShortestYawDelta(a1, a2) -- Line: 22 -- types: a1: number, a2: number
    local v1 = a2 - a1
    return (math.atan2(math.sin(v1), (math.cos(v1))))
end

function u5.StepYawToward(a1, a2, a3) -- Line: 28 -- upvalues: u5 (val) -- types: a1: number, a2: number, a3: number
    local v1 = u5.ShortestYawDelta(a1, a2)
    local v2 = a3 * 3.839724354387525
    local v3 = math.clamp(v1, -v2, v2)
    return a1 + v3, v3
end

function u5.StepMoveToward(a1, a2, a3, a4) -- Line: 40
    -- upvalues: u5 (val)
    local Position = a2.Position
    local v1 = a3 - Position
    local v2 = Vector3.new(v1.X, 0, v1.Z)
    local Magnitude = v2.Magnitude
    if Magnitude <= 0 then
        return a2, false, 0
    end
    local v3 = math.min(Magnitude, a4 * a1)
    local Unit = v2.Unit
    local LookVector = a2.LookVector
    local v4 = Vector3.new(LookVector.X, 0, LookVector.Z)
    v4 = u5.YawFromFlatDirection(if not (0 < v4.Magnitude) then Unit else v4.Unit)
    v2 = u5.YawFromFlatDirection(Unit)
    local v5, v6 = u5.StepYawToward(v4, v2, a1)
    v4 = math.clamp((math.cos((math.abs((u5.ShortestYawDelta(v5, v2))))) - 0.2) / 0.8, 0, 1)
    local v7 = (CFrame.new(Position + Unit * v3 * v4)) * CFrame.Angles(0, v5, 0)
    local v8 = true
    if not (v4 > 0) then
        v8 = 0.008726646259971648 < (math.abs(v6))
    end
    return v7, v8, a4 * v4
end

function u5.FaceOwnerCFrame(a1, a2, a3, a4) -- Line: 75
    -- upvalues: u5 (val)
    local Position = a1.Position
    local v1 = Vector3.new(a2.X - Position.X, 0, a2.Z - Position.Z)
    if v1.Magnitude <= 0 then
        return a1
    end
    local LookVector = a1.LookVector
    local v2 = Vector3.new(LookVector.X, 0, LookVector.Z)
    assert(0 < v2.Magnitude, "Asset wander CFrame must have a horizontal facing direction")
    local v3 = u5.YawFromFlatDirection(v2.Unit)
    v2 = u5.YawFromFlatDirection(v1.Unit)
    v1 = if a4 ~= true then u5.StepYawToward(v3, v2, a3) else v2
    return (CFrame.new(Position)) * CFrame.Angles(0, v1, 0)
end

function u5.StepFollowOwner(a1, a2, a3, a4, a5, a6, a7) -- Line: 104
    -- upvalues: AssetWanderArea (val), u5 (val)
    local v1 = AssetWanderArea.PointNearOwner(a1, a4, a5)
    local v2, v3, v4 = u5.StepMoveToward(a2, a3, v1, a6)
    if Vector3.new(v1.X - v2.Position.X, 0, v1.Z - v2.Position.Z).Magnitude <= a7 then
        v2 = u5.FaceOwnerCFrame(v2, a4, a2)
    end
    return v2, v3, v4
end

function u5.OwnerMoveVector(a1, a2, a3) -- Line: 125 -- types: a1: number, a2: vector?, a3: vector?
    if a2 == nil then
        return Vector3.new(0, 0, 0), nil
    end
    if a3 ~= nil and not (a1 <= 0) then
        local v1 = a2 - a3
        return Vector3.new(v1.X, 0, v1.Z) / a1, a2
    end
    return Vector3.new(0, 0, 0), a2
end

function u5.OrbitGreetingCFrame(a1, a2, a3, a4, a5, a6, a7, a8) -- Line: 141
    -- upvalues: AssetWanderArea (val), u5 (val)
    local Unit, v1
    local Position = a3.Position
    local v2 = Vector3.new(Position.X - a4.X, 0, Position.Z - a4.Z)
    if v2.Magnitude ~= 0 then
        local Unit_2 = v2.Unit
        Unit = ((Vector3.new(-Unit_2.Z, 0, Unit_2.X)) + Unit_2 * math.clamp((a6 - v2.Magnitude) / a6, -a8, a8)).Unit
    else
        local LookVector = a1.CFrame.LookVector
        v1 = Vector3.new(LookVector.X, 0, LookVector.Z)
        assert(0 < v1.Magnitude, "Asset area must provide a horizontal orbit greeting direction")
        Unit = v1.Unit
    end
    v2 = Unit * a7 + a5
    local v3 = Vector3.new(v2.X, 0, v2.Z)
    local Magnitude_2 = v2.Magnitude
    if v3.Magnitude <= 0 then
        return a3, false, 0
    end
    v3 = AssetWanderArea.ClampedPointToward(a1, Position + v2 * a2)
    v2 = Vector3.new(v3.X - Position.X, 0, v3.Z - Position.Z)
    if v2.Magnitude <= 0 then
        return a3, false, 0
    end
    v1 = u5.YawFromFlatDirection(v2.Unit)
    v1 = (CFrame.new(v3)) * CFrame.Angles(0, v1, 0)
    return v1, true, Magnitude_2
end

return u5