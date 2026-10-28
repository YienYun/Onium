-- Script path: ReplicatedStorage.Controllers.Game.Plots.ActiveAssetsController.AssetWanderArea
-- Decompile time: 1.32 ms

local u0 = {}

function u0.HalfExtents(a1) -- Line: 13 -- types: a1: userdata
    local Size = a1.Size
    return (math.max(Size.X * 0.5 - 1.75, 0)), (math.max(Size.Z * 0.5 - 1.75, 0))
end

function u0.ClampedPointToward(a1, a2) -- Line: 19 -- upvalues: u0 (val) -- types: a1: userdata, a2: vector
    local v1, v2 = u0.HalfExtents(a1)
    local v3 = a1.CFrame:PointToObjectSpace(a2)
    return (a1.CFrame * CFrame.new(math.clamp(v3.X, -v1, v1), 0, (math.clamp(v3.Z, -v2, v2)))).Position
end

function u0.RandomPoint(a1, a2) -- Line: 28 -- upvalues: u0 (val) -- types: a1: userdata, a2: userdata
    local v1, v2 = u0.HalfExtents(a1)
    return (a1.CFrame * CFrame.new(a2:NextNumber(-v1, v1), 0, (a2:NextNumber(-v2, v2)))).Position
end

function u0.IsPositionInside(a1, a2) -- Line: 36 -- upvalues: u0 (val) -- types: a1: userdata, a2: vector
    local v1, v2 = u0.HalfExtents(a1)
    local v3 = a1.CFrame:PointToObjectSpace(a2)
    local v4 = false
    if math.abs(v3.X) <= v1 then
        v4 = math.abs(v3.Z) <= v2
    end
    return v4
end

function u0.PointNearOwner(a1, a2, a3) -- Line: 43 -- upvalues: u0 (val) -- types: a1: userdata, a2: vector, a3: vector
    return u0.ClampedPointToward(a1, a2 + a3)
end

return u0